import rospy
def HRESULT_error(self,vt:int,value:str) -> None:
        """
        HRESULTエラーを発生した時のハンドリングを行う。現状はエラーログのみを出力する。
        
        Args:
            vt (int): HRESULTのvt。
            value (str): HRESULTのvalue。
        
        """
        rospy.logerr("cobotta/HRESULT_error: %s",vt)
        rospy.logerr("cobotta/HRESULT_error: %s",value)