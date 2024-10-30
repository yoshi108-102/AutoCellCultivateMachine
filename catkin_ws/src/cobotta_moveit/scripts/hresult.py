import rospy
def HRESULT(vt:int,value:str) -> None:
        """
        HRESULTのハンドリングを行う関数。
        
        Args:
            vt (int): HRESULTのvt。
            value (str): HRESULTのvalue。
        
        """
        if vt >= 0:
            rospy.loginfo("cobotta/HRESULT: %s",vt)
            rospy.loginfo("cobotta/HRESULT: %s",value)
        else:
            rospy.logerr("cobotta/HRESULT_error: %s",vt)
            rospy.logerr("cobotta/HRESULT_error: %s",value)