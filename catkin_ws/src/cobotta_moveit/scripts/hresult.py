#!/usr/bin/env python3
import rospy
from bcap_service.srv import bcapResponse
def HRESULT(response:bcapResponse,func_name:str) -> None:
        """
        HRESULTのハンドリングを行う関数。
        
        Args:
            response (bcapResponse): bcap_serviceのresponse。
        
        """
        hresult = response.HRESULT
        vt = response.vntRet.vt
        value = response.vntRet.value
        if hresult >= 0:
            rospy.loginfo("bcap_service success: %s", func_name)
            rospy.loginfo("vt: %d, value: %s", vt, value)
        else:
            rospy.logerr("bcap_service failed: %s", func_name)
            rospy.logerr("HRESULT: %d", hresult)
            rospy.logerr("vt: %d, value: %s", vt, value)