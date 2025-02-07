#!/usr/bin/env python3
import math
import os
import sys

import moveit_commander
import tf
import tf.transformations
from geometry_msgs.msg import PoseStamped

sys.path.append(os.path.join(os.path.dirname(__file__), ".."))
import rospy
from cobotta.constants import MODE
from geometry_msgs.msg import Quaternion
from mycobot.mycobot_k3hand import K3HandinMyCobot as K3Hand
from operater import Operater
from std_msgs.msg import Int32

DISH_OFFSET_ABOVE = 0.182
DISH_OFFSET_BELOW = 0.181

def open_dish(op: Operater, k3hand:K3Hand):
    pos = rospy.wait_for_message("object_pose_dish", PoseStamped)
    rospy.loginfo(pos)
     # 手を開く
    for i in range(2):
        k3hand.movej(25)
    # ディッシュのちょっと上まで移動
    is_succeed: bool = False
    pos.pose.position.x *= 0.90
    pos.pose.position.y *= 0.91
    pos.pose.position.z = 0.140
    pos.pose.orientation = Quaternion(1,0,0,0)
    for i in range(0,10):
        i *= 0.001
        pos.pose.position.z += i
        is_succeed = op.mc_move_to(pos)
        if is_succeed:
            break
        pos.pose.position.z -= i
    now_joints = op.mc_group.get_current_joint_values()
    now_joints[3] += 0.33
    op.mc_send_angles(now_joints)
    rospy.loginfo(now_joints)
    rospy.sleep(2)
    is_succeed = False
    # ディッシュの位置まで移動
    """ pos.pose.position.z -= DISH_OFFSET/6
    while not is_succeed:
        is_succeed = op.mc_move_to(pos) """
    # 手を閉じてディッシュを持ち上げる
    k3hand.movej(26)
    now_joints = op.mc_group.get_current_joint_values()
    now_joints[1] += 0.22
    op.mc_send_angles(now_joints)
    op.mc_send_angles([0]*6)
    return True

def main():
    rospy.init_node("pipetthing")
    moveit_commander.roscpp_initialize(sys.argv)
    k3hand = K3Hand()
    op = Operater()
    open_dish(op,k3hand)
    rospy.spin()


if __name__ == "__main__":
    main()
    