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

DISH_OFFSET = 0.1


def open_dish(pos: PoseStamped, op: Operater, k3hand:K3Hand):
    # ディッシュのちょっと上まで移動
    is_succeed: bool = False
    pos.pose.position.z += DISH_OFFSET
    pos.pose.orientation = Quaternion(1,0,0,0)
    while not is_succeed:
        is_succeed = op.mc_move_to(pos)
    # 手を開く
    k3hand.movej(25)
    rospy.sleep(1)
    is_succeed = False
    # ディッシュの位置まで移動
    pos.pose.position.z -= DISH_OFFSET/5
    while not is_succeed:
        is_succeed = op.mc_move_to(pos)
    # 手を閉じてディッシュを持ち上げる
    k3hand.movej(11)
    rospy.sleep(3)
    op.mc_send_angles([0.1]*6)
    return True

def main():
    rospy.init_node("pipetthing")
    moveit_commander.roscpp_initialize(sys.argv)
    k3hand = K3Hand()
    op = Operater()
    pos = rospy.wait_for_message("object_pose", PoseStamped)
    rospy.loginfo(pos)
    open_dish(pos,op,k3hand)
    rospy.spin()


if __name__ == "__main__":
    main()
    