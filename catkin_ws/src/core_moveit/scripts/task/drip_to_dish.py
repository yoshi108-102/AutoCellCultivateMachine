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
from cobotta.cobotta_arm import CobottaArmBcapInterface as Arm
from geometry_msgs.msg import Quaternion
from operater import Operater
from std_msgs.msg import Int32

if __name__ == "__main__":
    from change_mode import changeMode
else:
    from .change_mode import changeMode

"""
1. ピペットにアームを十分に近づける
2. 適切にアームを回転させる
3. ピペットを把持する
"""
DISH_OFFSET = 0.04

def drip_to_dish(op: Operater, arm: Arm):
    pos = rospy.wait_for_message("object_pose_dish", PoseStamped)
    is_success = False
    pos.pose.position.y += 0.04
    pos.pose.position.z = 0.24
    x, y, z, w = tf.transformations.quaternion_from_euler(math.pi / 2, math.pi, 0)
    pos.pose.orientation = Quaternion(x, y, z, w)
    while not is_success:
        is_success = op.cob_move_to(pos,having_constraint=False)
    """
    TODO:arm.k3Hand.movej(6)
    arm.k3Hand.movej(5)
    掴みやすいようになんかいい感じに回転
    """
    changeMode(0)
    arm.k3Hand.movej(3)
    # 1.ピペットの先端にアームの指先を移動
    arm.k3Hand.movej(4)
    arm.k3Hand.movej(8)
    arm.k3Hand.movej(7)
    arm.k3Hand.movej(6)
    for i in range(2):
        arm.k3Hand.movej(5)
        arm.k3Hand.movej(6)
    changeMode(514)


def main():
    import rospy

    rospy.init_node("catch_pipette")
    moveit_commander.roscpp_initialize(sys.argv)
    op = Operater()
    arm = Arm()
    changeMode(0)
    arm.controller_connect()
    arm.add_k3hand()
    arm.clear_error()
    changeMode(514)
    drip_to_dish(op, arm)
    changeMode(0)
    arm.k3Hand.movej(7)
    arm.k3Hand.movej(8)
    arm.k3Hand.movej(3)
    changeMode(514)
    rospy.spin()


if __name__ == "__main__":
    main()
