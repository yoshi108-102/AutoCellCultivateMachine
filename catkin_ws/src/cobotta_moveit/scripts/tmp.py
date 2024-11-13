#!/usr/bin/env python3
import rospy
import math
import moveit_commander
import sys
import tf2_ros
import tf2_geometry_msgs

from cobotta_k3hand import K3HandinCobotta as K3Hand
from hresult import HRESULT

from bcap_service.srv import bcapRequest, bcapResponse, bcap
from bcap_service.msg import variant
from constants import FUNC_ID, VARIANT_TYPES, MODE

class CobottaArmBcapInterface:
    """cobottaのアームを操作および拡張アイテム（K3Handなど）にアクセスするためのクラス。

    rosservice call /bcap_serviceをを使用してcobottaのアームを操作する。
    /bcap_serviceは引数が

    '{func_id: 3, vntArgs: [{vt: 8, value: "b-CAP"}, {vt: 8, value: "CaoProv.DENSO.VRC"}, {vt: 8, value: "192.168.0.1"}, {vt: 8, value: ""}] }'

    のような形式で面倒なため、これを簡潔に呼び出すためのラッパークラス。
    事前にcobottaのアームをethanetで接続し、接続したPCのipアドレスを192.168.0.9(デフォルト)に設定しておく必要がある。

    roslaunch denso_robot_ros bcap_service.launchでbcap_serviceを起動した上で使用する。

    スレーブモードでは動かないため、cobotta_bringup.launchをsim:=falseで実行している場合は使用できない。

    プログラム終了時には必ずmotor_off()およびgive_arm()を実行すること。

    Attributes:
        k3Hand (K3Hand): cobottaに接続されたK3Handのインスタンス。初期状態では空のK3Handインスタンスが設定されている。vtが-1の場合は接続に失敗している。
        hControllerVt (int): cobottaのコントローラハンドルのvt。各種値の取得等に使用する。
        hControllerValue (str): cobottaのコントローラハンドルの値。各種値の取得等に使用する。
        hRobotVt (int): cobottaのロボットハンドルのvt。アーム等の制御に使用する。
        hRobotValue (str): cobottaのロボットハンドルの値。アーム等の制御に使用する。
        ip_address (str): cobottaのipアドレス。デフォルトでは192.168.0.1。変更した場合はコンストラクタで指定する。
        is_takeArm (bool): cobottaのアーム制御権を取得したかどうかのフラグ。初期状態ではFalse。
        is_motor_on (bool): cobottaのモータがオンになっているかどうかのフラグ。初期状態ではFalse。
        changeModePub (rospy.Publisher): cobottaのモード変更を行うためのPublisher。Int32型のメッセージを送信する。なぜか一度空振りさせないと機能しないので、初期化の際に一度だけ送信を行う。
        curModeSub (rospy.Subscriber): cobottaのモード変更を行うためのSubscriber。Int32型のメッセージを受信する。モード変更を正確に検知する
        mode: 0: normal mode, 514: slave mode

    """

    def __init__(self, ip_address="192.168.0.1"):
        self.k3Hand = K3Hand(-1, "")

        self.hControllerVt = -1
        self.hControllerValue = ""
        self.hRobotVt = -1
        self.hRobotValue = ""

        self.ip_address = ip_address
        self.is_takeArm = False
        self.is_motor_on = False

        self.listener = TfListener()
        self.changeModePub = rospy.Publisher(
            "/cobotta/ChangeMode", Int32, queue_size=10
        )

        self.armActionPub = rospy.Publisher(
            "/cobotta/arm_controller/command", JointTrajectory, queue_size=10
        )
        
        self.pipettePointSub = rospy.Subscriber(
            "target_estimation", PoseStamped, self.pipettePointCallback
        )
        moveit_commander.roscpp_initialize(sys.argv)
        
        self.scene = moveit_commander.PlanningSceneInterface()
        self.move_group = moveit_commander.MoveGroupCommander("arm")
        self.robot = moveit_commander.RobotCommander()
        
        self.displayTrajectoryPub = rospy.Publisher(
            "/move_group/display_planned_path", DisplayTrajectory, queue_size=20
        )

        self.move_group.set_planning_time(0.03)

        self.mode = MODE.SLAVE
        
    def curModeCallback(self, msg: Int32):
        rospy.loginfo("msg")
        self.mode = msg.data
    
    def change_mode(self,mode:int):
        msg = Int32()
        msg.data = mode
        self.changeModePub.publish(msg)
        """ while (not rospy.is_shutdown()) and (self.mode != mode):
            rospy.sleep(0.1)
         """
        rospy.sleep(1)
        rospy.loginfo("cobotta/change_mode succeed: changed mode to %d",mode)
        
    def setup(self):
        self.controller_connect()
        self.controller_get_robot()
        self.clear_error()

    def free(self):
        self.give_arm()
        self.motor_off()
        self.robot_release()
        self.controller_disconnect()

    def controller_connect(self) -> None:
        bcapReq = bcapRequest()

        bcapReq.func_id = FUNC_ID.ID_CONTROLLER_CONNECT
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=""))
        bcapReq.vntArgs.append(
            variant(vt=VARIANT_TYPES.VT_BSTR, value="CaoProv.DENSO.RC8")
        )
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=""))
        bcapReq.vntArgs.append(
            variant(vt=VARIANT_TYPES.VT_BSTR, value="Server=" + self.ip_address)
        )

        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError(
                "cobotta/controller_connect: failed to connect cobotta controller"
            )

        HRESULT(bcapRes, "controller_connect")

        if bcapRes.vntRet.vt < 0:
            return
        self.hControllerVt = bcapRes.vntRet.vt
        self.hControllerValue = bcapRes.vntRet.value

    def controller_disconnect(self) -> None:
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_CONTROLLER_DISCONNECT
        if self.hControllerVt == -1:
            rospy.logerr(
                "cobotta/controller_disconnect: you don't get controller handle"
            )
            return
        bcapReq.vntArgs.append(
            variant(vt=self.hControllerVt, value=self.hControllerValue)
        )

        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            HRESULT(bcapRes, "controller_disconnect")
        except rospy.ServiceException as e:
            raise RuntimeError(
                "cobotta/controller_disconnect: failed to disconnect cobotta controller"
            )

    def robot_release(self) -> None:
        try:
            bcapReq = bcapRequest()
            bcapReq.func_id = FUNC_ID.ID_ROBOT_RELEASE
            if self.hRobotVt == -1:
                rospy.logerr("cobotta/robot_release: you don't get robot handle")
                return
            bcapReq.vntArgs.append(variant(vt=self.hRobotVt, value=self.hRobotValue))

            rospy.wait_for_service("/bcap_service")
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            self.hRobotVt = -1
            self.hRobotValue = ""
            HRESULT(bcapRes, "robot_release")
        except Exception as e:
            self.free()
            rospy.logerr(e.args)
            raise RuntimeError("cobotta/robot_release: failed to release robot")

    def add_k3hand(self) -> None:
        try:
            bcapReq = bcapRequest()
            bcapReq.func_id = FUNC_ID.ID_CONTROLLER_GETEXTENSION
            if self.hControllerVt == -1:
                rospy.logerr("cobotta/add_k3hand: you don't get controller handle")
                return
            bcapReq.vntArgs.append(
                variant(vt=self.hControllerVt, value=self.hControllerValue)
            )
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="K3Hand"))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=""))

            rospy.wait_for_service("/bcap_service")
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)

            HRESULT(bcapRes, "add_k3hand")
            self.k3Hand = K3Hand(bcapRes.vntRet.vt, bcapRes.vntRet.value)
        except Exception as e:
            self.free()
            rospy.logerr(e.args)
            raise RuntimeError("cobotta/add_k3hand: failed to add k3hand")

    def clear_error(self):
        try:
            bcapReq = bcapRequest()
            bcapReq.func_id = FUNC_ID.ID_CONTROLLER_EXECUTE
            if self.hControllerVt == -1:
                rospy.logerr("cobotta/clear_error: you don't get controller handle")
                return

            bcapReq.vntArgs.append(
                variant(vt=self.hControllerVt, value=self.hControllerValue)
            )
            bcapReq.vntArgs.append(
                variant(vt=VARIANT_TYPES.VT_BSTR, value="ClearError")
            )
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=""))

            rospy.wait_for_service("/bcap_service")
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            HRESULT(bcapRes, "clear_error")

        except Exception as e:
            self.free()
            rospy.logerr(e.args)
            raise RuntimeError("cobotta/clear_error: failed to clear error")

    def controller_get_robot(self) -> None:
        try:
            bcapReq = bcapRequest()
            bcapReq.func_id = FUNC_ID.ID_CONTROLLER_GETROBOT
            if self.hControllerVt == -1:
                rospy.logerr(
                    "cobotta/controller_get_robot: you don't get controller handle"
                )
                return
            bcapReq.vntArgs.append(
                variant(vt=self.hControllerVt, value=self.hControllerValue)
            )
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="Arm"))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=""))

            rospy.wait_for_service("/bcap_service")
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)

            HRESULT(bcapRes, "controller_get_robot")
            self.hRobotVt = bcapRes.vntRet.vt
            self.hRobotValue = bcapRes.vntRet.value
        except Exception as e:
            self.free()
            rospy.logerr(e.args)
            raise RuntimeError(
                "cobotta/controller_get_robot: failed to get robot handle"
            )

    def take_arm(self) -> None:
        try:
            if self.is_takeArm:
                rospy.loginfo("cobotta/take_arm: you already take arm")
                return
            bcapReq = bcapRequest()
            bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
            if self.hRobotVt == -1:
                rospy.logerr("cobotta/take_arm: you don't get robot handle")
                return
            bcapReq.vntArgs.append(variant(vt=self.hRobotVt, value=self.hRobotValue))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="Takearm"))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=""))

            rospy.wait_for_service("/bcap_service")
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            self.is_takeArm = True
            HRESULT(bcapRes, "take_arm")
        except Exception as e:
            self.free()
            rospy.logerr(e.args)
            raise RuntimeError("cobotta/take_arm: failed to take arm")

    def give_arm(self) -> None:
        if self.is_takeArm == False:
            rospy.loginfo("cobotta/give_arm: you don't take arm")
            return

        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
        if self.hRobotVt == -1:
            rospy.logerr("cobotta/give_arm: you don't get robot handle")
            return
        bcapReq.vntArgs.append(variant(vt=self.hRobotVt, value=self.hRobotValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="Givearm"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=""))

        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            self.is_takeArm = False
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/give_arm: failed to give arm")

        HRESULT(bcapRes, "give_arm")

    def motor_on(self):
        try:
            if self.is_motor_on:
                rospy.loginfo("cobotta/motor_on: you already motor on")
                return
            bcapReq = bcapRequest()
            bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
            if self.hRobotVt == -1:
                rospy.logerr("cobotta/motor_on: you don't get robot handle")
                return
            bcapReq.vntArgs.append(variant(vt=self.hRobotVt, value=self.hRobotValue))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="Motor"))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="1"))

            rospy.wait_for_service("/bcap_service")
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            self.is_motor_on = True
            HRESULT(bcapRes, "motor_on")
        except rospy.ServiceException as e:
            self.free()
            rospy.logerr(e.args)
            raise RuntimeError("cobotta/motor_on: failed to motor on")

    def motor_off(self):
        if self.is_motor_on == False:
            rospy.loginfo("cobotta/motor_off: you already motor off")
            return
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
        if self.hRobotVt == -1:
            rospy.logerr("cobotta/motor_off: you don't get robot handle")
            return
        bcapReq.vntArgs.append(variant(vt=self.hRobotVt, value=self.hRobotValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="Motor"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="0"))

        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            self.is_motor_on = False
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/motor_off: failed to motor off")

        HRESULT(bcapRes, "motor_off")

    def move(self, location_comp: int, vntPose: str, bstrOption: str) -> None:
        """
        cobottaのアームを指定位置に移動する。
        事前にロボットハンドルを取得している必要がある。
        事前にアーム制御権を取得している必要がある。
        事前にモータがオンになっている必要がある。
        具体的な指定方法はPacScriptのマニュアルを参照。

        Args:
            location_comp : 補完指定番号を表す。

                1: Move P

                2: Move L

                3: Move C

                4: Move S

            vntPose: ポーズ列を指定する。

            bstrOption: 動作オプションを指定する。

        Raises:
            RuntimeError: 移動に失敗した場合に発生。

        Examples:
            ```python
            todo
            ```
        """
        try:
            bcapReq = bcapRequest()
            bcapReq.func_id = FUNC_ID.ID_ROBOT_MOVE
            if self.hRobotVt == -1:
                rospy.logerr("cobotta/move: you don't get robot handle")
                return
            if self.is_takeArm == False:
                rospy.logerr("cobotta/move: you don't take arm")
                return
            if self.is_motor_on == False:
                rospy.logerr("cobotta/move: you don't motor on")
                return

            bcapReq.vntArgs.append(variant(vt=self.hRobotVt, value=self.hRobotValue))
            bcapReq.vntArgs.append(
                variant(vt=VARIANT_TYPES.VT_I4, value=str(location_comp))
            )
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=vntPose))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=bstrOption))

            rospy.wait_for_service("/bcap_service")
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            HRESULT(bcapRes, "move")
        except rospy.ServiceException as e:
            self.free()
            rospy.logerr(e.args)
            raise RuntimeError("cobotta/move: failed to move")

    def approach(
        self, location_comp: int, vntPoseBase: str, vntPoseLen: str, strOpt: str
    ) -> None:
        """
        cobottaのアームを指定位置に近づける。
        事前にロボットハンドルを取得している必要がある。
        事前にアーム制御権を取得している必要がある。
        事前にモータがオンになっている必要がある。
        具体的な指定方法はPacScriptのマニュアルを参照。

        Args:
            location_comp : 補完指定番号を表す。

                1: Move P

                2: Move C

            vntPoseBase: ポーズ列を指定する。

            vntPoseLen: ポーズ列を指定する。

            strOpt: 動作オプションを指定する。

        Raises:
            RuntimeError: 近づけに失敗した場合に発生。

        Examples:
            ```python
            todo
            ```
        """
        try:
            bcapReq = bcapRequest()
            bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
            if self.hRobotVt == -1:
                rospy.logerr("cobotta/approach: you don't get robot handle")
                return
            if self.is_takeArm == False:
                rospy.logerr("cobotta/approach: you don't take arm")
                return
            if self.is_motor_on == False:
                rospy.logerr("cobotta/approach: you don't motor on")
                return

            bcapReq.vntArgs.append(variant(vt=self.hRobotVt, value=self.hRobotValue))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="Approach"))
            """  bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_I4,value=str(location_comp)))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=vntPoseBase))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=vntPoseLen))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=strOpt)) 
            """
            value = ""
            value += "(" + str(VARIANT_TYPES.VT_I4) + "," + str(location_comp) + ")"
            value += ","
            value += "(" + str(VARIANT_TYPES.VT_BSTR) + "," + vntPoseBase + ")"
            value += ","
            value += "(" + str(VARIANT_TYPES.VT_BSTR) + "," + vntPoseLen + ")"
            value += ","
            value += "(" + str(VARIANT_TYPES.VT_BSTR) + "," + strOpt + ")"
            bcapReq.vntArgs.append(
                variant(
                    vt=VARIANT_TYPES.VT_VARIANT | VARIANT_TYPES.VT_ARRAY, value=value
                )
            )

            rospy.wait_for_service("/bcap_service")

            bcapRes: bcapResponse = bcapResponse()
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)

            HRESULT(bcapRes, "approach")
        except rospy.ServiceException as e:
            self.free()
            rospy.logerr(e.args)
            raise RuntimeError("cobotta/approach: failed to approach")

    def depart(self, location_comp: int, vntPoseLen: str, strOpt: str) -> None:
        """
        cobottaのアームを指定位置から離れる。
        事前にロボットハンドルを取得している必要がある。
        事前にアーム制御権を取得している必要がある。
        事前にモータがオンになっている必要がある。
        具体的な指定方法はPacScriptのマニュアルを参照。

        Args:
            location_comp : 補完指定番号を表す。

                1: Move P

                2: Move C

            vntPoseLen: ポーズ列を指定する。

            strOpt: 動作オプションを指定する。

        Raises:
            RuntimeError: 離れるに失敗した場合に発生。

        Examples:
            ```python
            todo
            ```
        """
        try:
            bcapReq = bcapRequest()
            bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
            if self.hRobotVt == -1:
                rospy.logerr("cobotta/depart: you don't get robot handle")
                return
            if self.is_takeArm == False:
                rospy.logerr("cobotta/depart: you don't take arm")
                return
            if self.is_motor_on == False:
                rospy.logerr("cobotta/depart: you don't motor on")
                return

            bcapReq.vntArgs.append(variant(vt=self.hRobotVt, value=self.hRobotValue))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="Depart"))
            """  
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_I4,value=str(location_comp)))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=vntPoseLen))
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=strOpt)) """

            value = ""
            value += "(" + str(VARIANT_TYPES.VT_I4) + "," + str(location_comp) + ")"
            value += ","
            value += "(" + str(VARIANT_TYPES.VT_BSTR) + "," + vntPoseLen + ")"
            value += ","
            value += "(" + str(VARIANT_TYPES.VT_BSTR) + "," + strOpt + ")"
            bcapReq.vntArgs.append(
                variant(
                    vt=VARIANT_TYPES.VT_VARIANT | VARIANT_TYPES.VT_ARRAY, value=value
                )
            )

            rospy.wait_for_service("/bcap_service")

            bcapRes: bcapResponse = bcapResponse()
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except Exception as e:
            self.free()
            rospy.logerr(e.args)
            raise RuntimeError("cobotta/depart: failed to depart")

        HRESULT(bcapRes, "depart")
    def pipettePointCallback(self, msg:PoseStamped,deg=0):
        if (rospy.Time.now() - msg.header.stamp) > rospy.Duration(0.05):
            return
        msg.header.frame_id = "Head"
        transform_stamped = self.listener.lookupTransform(
            "base_link", msg.header.frame_id
        )
        x, y, z = (
            transform_stamped.transform.translation.x,
            transform_stamped.transform.translation.y,
            transform_stamped.transform.translation.z,
        )
        try:
            self.move_group.set_pose_target([x, y, z, -math.pi, 0, 0])
            p = self.move_group.plan()
            tar_jo = list(p[1].joint_trajectory.points[-1].positions)
            rospy.loginfo(tar_jo)
            self.move_group.go(tar_jo,wait=True)
            rospy.sleep(1)
        except Exception as e:
            rospy.logerr(e)
            rospy.loginfo("Failed to move end effector")
    
    def manual_reset(self):
        
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_CONTROLLER_EXECUTE
        if self.hControllerVt == -1:
            rospy.logerr("cobotta/manual_reset: you don't get controller handle")
            return

        bcapReq.vntArgs.append(
            variant(vt=self.hControllerVt, value=self.hControllerValue)
        )
        bcapReq.vntArgs.append(
            variant(vt=VARIANT_TYPES.VT_BSTR, value="ManualResetPreparation")
        )
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=""))
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            HRESULT(bcapRes, "manual_reset")
        except rospy.ServiceException as e:
            self.free()
            raise RuntimeError("cobotta/manual_reset: failed to manual reset")
        
        HRESULT(bcapRes, "manual_reset")
        

if __name__ == "__main__":
    rospy.init_node("cobotta_arm")
