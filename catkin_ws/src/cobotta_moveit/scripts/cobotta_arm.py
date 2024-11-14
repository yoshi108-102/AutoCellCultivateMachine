#!/usr/bin/env python3
import rospy
import math

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
    """

    def __init__(self, ip_address="192.168.0.1"):
        self.k3Hand = None

        self.hControllerVt = -1
        self.hControllerValue = ""
        self.hRobotVt = -1
        self.hRobotValue = ""

        self.ip_address = ip_address
        self.is_takeArm = False
        self.is_motor_on = False
        self.mode = MODE.SLAVE
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
    cobotta = CobottaArmBcapInterface()
    cobotta.controller_connect()
    cobotta.add_k3hand()
    cobotta.k3Hand.movej(0)
    rospy.sleep(0.5)
    cobotta.k3Hand.movej(2)
    rospy.sleep(0.5)
    cobotta.k3Hand.movej(3)
    rospy.sleep(0.5)
    cobotta.k3Hand.movej(4)
    cobotta.free()
