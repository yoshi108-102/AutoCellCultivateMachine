from cobotta_arm import CobottaArm
import rospy
def main():
    cobotta = CobottaArm()
    
    #cobottaに接続
    cobotta.controller_connect()
    cobotta.controller_get_robot()
    cobotta.add_k3hand()
    
    