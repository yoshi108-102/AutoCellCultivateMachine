from cobotta_k3hand import K3HandinCobotta as K3Hand
from hresult_error import HRESULT_error
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
    
    Attributes:
        k3Hand (K3Hand): cobottaに接続されたK3Handのインスタンス。
        hControllerHandle (str): cobottaのハンドル。
        ip_address (str): cobottaのipアドレス。デフォルトでは192.168.0.1。変更した場合はコンストラクタで指定する。
    
    """
    def __init__(self,ip_address="192.168.0.1"):
        self.k3Hand = None
        self.hControllerHandleVt = -1
        self.hControllerHandleValue = ""
        self.ip_address = ip_address
    
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
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="CaoProv.DENSO.VRC"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=self.ip_address))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/controller_connect: failed to connect cobotta controller")
        
        if bcapRes.vntRet[0].vt < 0:
            HRESULT_error(bcapRes.vntRet[0].vt,bcapRes.vntRet[0].value)
            return
        self.hControllerHandleVt = bcapRes.vntRet[0].vt
        self.hControllerHandleValue = bcapRes.vntRet[0].value
    def add_k3hand(self) -> None:
        """
        cobottaに接続されたK3Handのコントローラに接続し、ハンドルを取得する。成功したらK3Handのインスタンスを作成する。
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
        if self.hControllerHandleVt == -1:
            rospy.logerr("cobotta/add_k3hand: you don't get controller handle")
            return
        bcapReq.vntArgs.append(variant(vt=self.hControllerHandleVt,value=self.hControllerHandleValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="K3Hand"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/add_k3hand: failed to connect k3hand controller")
        
        if bcapRes.vntRet[0].vt != 0:
            HRESULT_error(bcapRes.vntRet[0].vt,bcapRes.vntRet[0].value)
            return
        self.k3Hand = K3Hand(bcapRes.vntRet[0].vt,bcapRes.vntRet[0].value)
    
    def clear_error(self):
        """
        cobottaのエラーをクリアする。
        
        Raises:
            RuntimeError: クリアに失敗した場合に発生。
        """
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_CONTROLLER_EXECUTE
        if self.hControllerHandleVt == -1:
            rospy.logerr("cobotta/clear_error: you don't get controller handle")
            return
        
        bcapReq.vntArgs.append(variant(vt=self.hControllerHandleVt,value=self.hControllerHandleValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value="ClearError"))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR,value=""))
        
        try:
            bcapSrv = rospy.ServiceProxy("/bcap_service",bcap)
            bcapRes: bcapResponse = bcapSrv(bcapReq)
        except rospy.ServiceException as e:
            raise RuntimeError("cobotta/clear_error: failed to clear error")
        
        if bcapRes.vntRet[0].vt != 0:
            HRESULT_error(bcapRes.vntRet[0].vt,bcapRes.vntRet[0].value)
            return