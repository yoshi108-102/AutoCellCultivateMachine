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

from .change_mode import changeMode


def pipetthing(arm: Arm, num: int):
    changeMode(0)
    arm.k3Hand.movej(3)
    # 1.ピペットの先端にアームの指先を移動
    arm.k3Hand.movej(4)
    arm.k3Hand.movej(8)
    arm.k3Hand.movej(7)

    # 2.ピペッティング作業
    for _ in range(num):
        arm.k3Hand.movej(6)
        arm.k3Hand.movej(5)
    arm.k3Hand.movej(7)
    arm.k3Hand.movej(8)
    arm.k3Hand.movej(3)
    changeMode(514)


def main():
    rospy.init_node("pipetthing")
    moveit_commander.roscpp_initialize(sys.argv)
    arm = Arm()
    changeMode(0)
    arm.controller_connect()
    arm.add_k3hand()
    arm.clear_error()

    pipetthing(arm, 5)
    rospy.spin()


if __name__ == "__main__":
    main()
