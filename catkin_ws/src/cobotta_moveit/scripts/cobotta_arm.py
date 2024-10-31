#!/usr/bin/env python3
from cobotta_k3hand import K3HandinCobotta as K3Hand
from hresult import HRESULT
import rospy

from bcap_service.srv import bcapRequest, bcapResponse,bcap
from bcap_service.msg import variant
from constants import FUNC_ID,VARIANT_TYPES

class CobottaArm():
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
    
    """
    def __init__(self,ip_address="192.168.0.1"):
        self.k3Hand = K3Hand(-1,"")
        self.hControllerVt = -1
        self.hControllerValue = ""
        self.hRobotVt = -1
        self.hRobotValue = ""
        self.ip_address = ip_address
        self.is_takeArm = False
        self.is_motor_on = False
        
    def controller_connect(self) -> None:
        """
        cobottaのコントローラに接続し、成功した場合はハンドルを取得する。
        
        Raises:
            RuntimeError: 接続に失敗した場合に発生。
            
        Examples:
            ```python
            cobotta = CobottaArm()
            cobotta.controller_connect()
            ```
        """
        bcapReq = bcapRequest()
        
        bcapReq.func_id = FUNC_ID.ID_CONTROLLER_CONNECT
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="CaoProv.DENSO.RC8"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="Server="+self.ip_address))
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/controller_connect: failed to connect cobotta controller")
        
        HRESULT(bcapRes,"controller_connect")
        
        if bcapRes.vntRet.vt < 0:
            return
        self.hControllerVt = bcapRes.vntRet.vt
        self.hControllerValue = bcapRes.vntRet.value
        
    def add_k3hand(self) -> None:
        """
        cobottaに接続されたK3Handのコントローラに接続し、ハンドルを取得する。成功したらK3Handのインスタンスを作成する。
        事前にcobottaのコントローラに接続している必要がある。
        
        Raises:
            RuntimeError: 接続に失敗した場合に発生。
        Examples:
            ```python
            cobotta = CobottaArm()
            cobotta.controller_connect()
            cobotta.add_k3hand()
            ```
        """
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_CONTROLLER_GETEXTENSION
        if self.hControllerVt == -1:
            rospy.logerr("cobotta/add_k3hand: you don't get controller handle")
            return
        bcapReq.vntArgs.append(variant(vt=self.hControllerVt,value=self.hControllerValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="K3Hand"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/add_k3hand: failed to connect k3hand controller")
        
        HRESULT(bcapRes,"add_k3hand")
        self.k3Hand = K3Hand(bcapRes.vntRet.vt,bcapRes.vntRet.value)
    def clear_error(self):
        """
        cobottaのエラーをクリアする。
        事前にcobottaのコントローラに接続している必要がある。
        
        Raises:
            RuntimeError: クリアに失敗した場合に発生。
        
        Examples:
            ```python
            cobotta = CobottaArm()
            cobotta.controller_connect()
            cobotta.clear_error()
            ```
        """
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_CONTROLLER_EXECUTE
        if self.hControllerVt == -1:
            rospy.logerr("cobotta/clear_error: you don't get controller handle")
            return
        
        bcapReq.vntArgs.append(variant(vt=self.hControllerVt,value=self.hControllerValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="ClearError"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/clear_error: failed to clear error")
        
        HRESULT(bcapRes,"clear_error")
        
        if bcapRes.vntRet.vt != 0:
            return
    def controller_get_robot(self) -> None:
        """
        cobottaのロボットハンドルを取得する。
        事前にcobottaのコントローラに接続している必要がある。
        
        Raises:
            RuntimeError: ハンドルの取得に失敗した場合に発生。
        
        Examples:
            ```python
            cobotta = CobottaArm()
            cobotta.controller_connect()
            cobotta.controller_get_robot()
            ```
        """
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_CONTROLLER_GETROBOT
        if self.hControllerVt == -1:
            rospy.logerr("cobotta/controller_get_robot: you don't get controller handle")
            return
        bcapReq.vntArgs.append(variant(vt=self.hControllerVt,value=self.hControllerValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="Arm"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/controller_get_robot: failed to get robot handle")
        
        HRESULT(bcapRes,"controller_get_robot")

        self.hRobotVt = bcapRes.vntRet.vt
        self.hRobotValue = bcapRes.vntRet.value
    def take_arm(self) -> None:
        """
        cobottaのアーム制御権を取得する。
        事前にcobottaのロボットハンドルを取得している必要がある。
        すでに制御権を取得している場合は何もしない。
        
        Raises:
            RuntimeError: 制御権の取得に失敗した場合に発生。
        Examples:
            ```python
            cobotta = CobottaArm()
            cobotta.controller_connect()
            cobotta.controller_get_robot()
            cobotta.take_arm()
            ```
        """
        if self.is_takeArm:
            rospy.loginfo("cobotta/take_arm: you already take arm")
            return
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
        if self.hRobotVt == -1:
            rospy.logerr("cobotta/take_arm: you don't get robot handle")
            return
        bcapReq.vntArgs.append(variant(vt=self.hRobotVt,value=self.hRobotValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="Takearm"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            self.is_takeArm = True
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/take_arm: failed to take arm")

        HRESULT(bcapRes,"take_arm")
    
    def give_arm(self) -> None:
        """
        cobottaのアーム制御権を解放する。
        事前にcobottaのロボットハンドルを取得している必要がある。
        制御権を取得していない場合は何もしない。
        
        Raises:
            RuntimeError: 制御権の解放に失敗した場合に発生。
        Examples:
            ```python
            cobotta = CobottaArm()
            cobotta.controller_connect()
            cobotta.controller_get_robot()
            cobotta.take_arm()
            cobotta.give_arm()
            ```
        
        """
        if self.is_takeArm == False:
            rospy.loginfo("cobotta/give_arm: you don't take arm")
            return
    
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
        if self.hRobotVt == -1:
            rospy.logerr("cobotta/give_arm: you don't get robot handle")
            return
        bcapReq.vntArgs.append(variant(vt=self.hRobotVt,value=self.hRobotValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="Givearm"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            self.is_takeArm = False
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/give_arm: failed to give arm")
        
        HRESULT(bcapRes,"give_arm")
    
    def motor_on(self):
        """
        cobottaのモータをオンにする。
        事前にロボットハンドルを取得している必要がある。
        すでにモータがオンになっている場合は何もしない。
        
        Raises:
            RuntimeError: モータのオンに失敗した場合に発生。
        
        Examples:
            ```python
            cobotta = CobottaArm()
            cobotta.controller_connect()
            cobotta.controller_get_robot()
            cobotta.motor_on()
            ```
            
        """
        if self.is_motor_on:
            rospy.loginfo("cobotta/motor_on: you already motor on")
            return
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
        if self.hRobotVt == -1:
            rospy.logerr("cobotta/motor_on: you don't get robot handle")
            return
        bcapReq.vntArgs.append(variant(vt=self.hRobotVt,value=self.hRobotValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="Motor"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="1"))        
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            self.is_motor_on = True
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/motor_on: failed to motor on")
        
        HRESULT(bcapRes,"motor_on")
    
    def motor_off(self):
        """
        cobottaのモータをオフにする。
        事前にロボットハンドルを取得している必要がある。
        すでにモータがオフになっている場合は何もしない。
        プログラム終了時には必ずモータをオフにすること。
        Raises:
            RuntimeError: モータのオフに失敗した場合に発生。
        
        Examples:
            ```python
            cobotta = CobottaArm()
            cobotta.controller_connect()
            cobotta.controller_get_robot()
            cobotta.motor_on()
            cobotta.motor_off()
            ```
        """
        if self.is_motor_on == False:
            rospy.loginfo("cobotta/motor_off: you already motor off")
            return
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_ROBOT_EXECUTE
        if self.hRobotVt == -1:
            rospy.logerr("cobotta/motor_off: you don't get robot handle")
            return
        bcapReq.vntArgs.append(variant(vt=self.hRobotVt,value=self.hRobotValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="Motor"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="0"))        
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
            self.is_motor_on = False
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/motor_off: failed to motor off")
        
        HRESULT(bcapRes,"motor_off")

    def move(self,location_comp:int,vntPose:str,bstrOption:str) -> None:
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
        
        bcapReq.vntArgs.append(variant(vt=self.hRobotVt,value=self.hRobotValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_I4,value=str(location_comp)))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=vntPose))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=bstrOption))
        
        rospy.wait_for_service("/bcap_service")
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/move: failed to move")

        HRESULT(bcapRes,"move")
    
    def approach(self,location_comp:int,vntPoseBase:str,vntPoseLen:str,strOpt:str) -> None:
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
        
        bcapReq.vntArgs.append(variant(vt=self.hRobotVt,value=self.hRobotValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="Approach"))
        """  bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_I4,value=str(location_comp)))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=vntPoseBase))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=vntPoseLen))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=strOpt)) 
        """
        value= ""
        value += "(" + str(VARIANT_TYPES.VT_I4) + "," + str(location_comp) + ")"
        value += ","
        value += "(" + str(VARIANT_TYPES.VT_BSTR) + "," + vntPoseBase + ")"
        value += ","
        value += "(" + str(VARIANT_TYPES.VT_BSTR) + "," + vntPoseLen + ")"
        value += ","
        value += "(" + str(VARIANT_TYPES.VT_BSTR) + "," + strOpt + ")"
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_VARIANT | VARIANT_TYPES.VT_ARRAY,value=value))
        
        rospy.wait_for_service("/bcap_service")
        
        bcapRes: bcapResponse = bcapResponse()
        
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/approach: failed to approach")
        
        HRESULT(bcapRes,"approach")
        
    def depart(self,location_comp:int,vntPoseLen:str,strOpt:str) -> None:
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
        
        bcapReq.vntArgs.append(variant(vt=self.hRobotVt,value=self.hRobotValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="Depart"))
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
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_VARIANT | VARIANT_TYPES.VT_ARRAY,value=value))
        
        rospy.wait_for_service("/bcap_service")
        
        bcapRes: bcapResponse = bcapResponse()
        
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/depart: failed to depart")
        
        HRESULT(bcapRes,"depart")
if __name__ == "__main__":
    rospy.init_node("cobotta_arm")
    rospy.loginfo("dish_grasp_test")
    cobotta = CobottaArm()
    cobotta.controller_connect()
    cobotta.controller_get_robot()
    cobotta.clear_error()
    cobotta.motor_on()
    cobotta.take_arm()
    cobotta.move(1,"@0 P5","")
    cobotta.approach(1,"P11","@0 50","")
    cobotta.add_k3hand()
    cobotta.k3Hand.movej(10)
    cobotta.move(2,"@0 P11","")
    cobotta.k3Hand.movej(11)
    rospy.sleep(1)
    cobotta.depart(1, "@0 50","")
    rospy.sleep(1)
    cobotta.move(2, "@0 P11","")
    cobotta.k3Hand.movej(10)
    cobotta.depart(1, "@0 50","")
    cobotta.give_arm()
    cobotta.motor_off()
    