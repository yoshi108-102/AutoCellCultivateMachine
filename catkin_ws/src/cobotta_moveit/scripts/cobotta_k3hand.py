#! /usr/bin/env python3
from typing import overload

import rospy
from bcap_service.msg import variant
from bcap_service.srv import bcap, bcapRequest, bcapResponse
from constants import FUNC_ID, VARIANT_TYPES
from hresult import HRESULT


class K3HandinCobotta:
    """cobottaに接続されたK3Handを操作するためのクラス。

    K3Handを操作するための関数を提供する。
    関数は全てrossevice call /bcap_serviceのラッパーとして実装されている。
    standaloneのK3Handを操作する場合は使用できない。
    スレーブモードでは動かないため、cobotta_bringup.launchをsim:=falseで実行している場合は使用できない。

    Attributes:
        handleVt (int): cobottaのハンドルのvt。
        handleValue (str): cobottaのハンドルの値。
        speed (int): K3Handの動作速度。デフォルトは100。

    """

    def __init__(self, vt: int, value: str):
        self.handleVt = vt
        self.handleValue = value
        self.speed = 100

    @overload
    def movej(self, location_point_number: int) -> None: ...
    @overload
    def movej(self, seeach_pose: list) -> None: ...
    def movej(self, arg) -> None:
        rospy.loginfo(self.handleVt)
        """
        K3Handを指定した位置に移動させる関数。

        bcap_slave_modeでは実行不可であり、`cobotta_bringup`を`sim:=false`で実行中は使用できません。

        Args:
            location_point_number (int): virtual TPで指定した位置番号。
            each_pose (list[tuple[int, int]]): K3Handの各関節の角度を指定するリスト。各要素はタプル形式で、(関節番号, 角度)。
            all_pose (list[int]): K3Handの全関節の角度を指定するリスト。6つの要素から成り、各要素は対応する関節の角度。

        Raises:
            ValueError: 引数が無効な場合に発生。

        Examples:
            ```python
            movej(1)                   # 指定位置番号1へ移動
            movej([[1, 30], [2, -50]]) # 関節1を30度、関節2を-50度に設定
            movej([0, 0, 0, 0, 0, 0])  # 全関節の角度を0度に設定
            ```
        """
        if self.handleVt == "-1":
            rospy.logerr("cobotta/movej: you don't get k3hand controller hundle")
            return
        bcapReq = bcapRequest()
        bcapReq.func_id = FUNC_ID.ID_EXTENSION_EXECUTE
        bcapReq.vntArgs.append(variant(vt=self.handleVt, value=self.handleValue))
        bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value="MoveJ"))
        if type(arg) == int:
            bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_I4, value=str(arg)))
        elif type(arg) == list:
            if arg.len() == 0:
                raise ValueError("cobotta/movej: arg is empty")
            if type(arg[0]) == list:
                # [[1, 30], [2, -50]]
                value = ""
                for e in arg:
                    value += "(" + str(e[0]) + "," + str(e[1]) + ")"
                    value += ","
                value = value[:-1]
                bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=value))
            if type(arg[0]) == int:
                if len(arg) != 6:
                    raise ValueError("cobotta/movej: all_pose must have 6 elements")
                # [0, 0, 0, 0, 0, 0]
                value = "J("
                for e in arg:
                    value += str(e)
                    value += ","
                value = value[:-1]
                value += ")"
                bcapReq.vntArgs.append(variant(vt=VARIANT_TYPES.VT_BSTR, value=value))
        else:
            raise ValueError("cobotta/movej: arg type is invalid")
        bcapRes = bcapResponse()

        rospy.wait_for_service("/bcap_service")
        try:
            bcapService = rospy.ServiceProxy("/bcap_service", bcap)
            bcapRes = bcapService(bcapReq)
        except rospy.ServiceException as e:
            rospy.logerr("cobotta/movej: Service call failed: %s", e)
            return

        HRESULT(bcapRes, "movej")
