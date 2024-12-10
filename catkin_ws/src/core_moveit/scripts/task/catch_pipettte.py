#!/usr/bin/env python3
from geometry_msgs.msg import PoseStamped
import moveit_commander
import sys
import os
sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
from operater import Operater
from cobotta.cobotta_arm import CobottaArmBcapInterface as Arm
import rospy
from std_msgs.msg import Int32
from change_mode import changeMode
"""
1. ピペットにアームを十分に近づける
2. 適切にアームを回転させる
3. ピペットを把持する
"""
def catch_pipette(pos:PoseStamped,op:Operater,arm:Arm):
    is_success = False
    while not is_success:
        is_success = op.cob_move_to(pos)
    """
    TODO:
    掴みやすいようになんかいい感じに回転
    """
    changeMode(0)
    rospy.sleep(1)
    arm.k3Hand.movej(0)
    arm.k3Hand.movej(1)
    arm.k3Hand.movej(2)
    arm.k3Hand.movej(3)
def main():
    import rospy
    rospy.init_node('catch_pipette')
    moveit_commander.roscpp_initialize(sys.argv)
    op = Operater()
    arm = Arm()
    changeMode(0)
    arm.controller_connect()
    arm.add_k3hand()
    arm.clear_error()
    changeMode(514)
    pos = rospy.wait_for_message('object_pose',PoseStamped)
    catch_pipette(pos,op,arm)
    rospy.spin()
if __name__ == '__main__':
    main()