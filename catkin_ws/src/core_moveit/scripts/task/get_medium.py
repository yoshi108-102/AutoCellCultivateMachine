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
    from pipetthing import pipetthing
else:
    from .change_mode import changeMode
    from .pipetthing import pipetthing
"""
1. ピペットにアームを十分に近づける
2. 適切にアームを回転させる
3. ピペットを把持する
"""


def move_to_pose(pos, op: Operater, arm: Arm):
    is_success = False
    is_success = op.cob_joint_targets(joint_list=pos)
    if not is_success:
        exit()
    """
    TODO:
    掴みやすいようになんかいい感じに回転
    """

def get_medium(op:Operater,arm:Arm):
    changeMode(514)
    pos = [-40.04,-5.35,127.41,-55.21,-47.55,-49.88]
    pos = [pos[i]*math.pi/180.0 for i in range(6)]
    move_to_pose(pos,op,arm)
    changeMode(0)
    arm.k3Hand.movej(3)
    # 1.ピペットの先端にアームの指先を移動
    arm.k3Hand.movej(4)
    arm.k3Hand.movej(8)
    arm.k3Hand.movej(7)
    arm.k3Hand.movej(6)
    arm.k3Hand.movej(5)
    changeMode(514)
    pos = [-40.04,14.68,127.41,-55.21,-47.55,-49.88]
    pos = [pos[i]*math.pi/180.0 for i in range(6)]
    move_to_pose(pos,op,arm)
    changeMode(0)
    arm.k3Hand.movej(5)
    rospy.sleep(1)
    arm.k3Hand.movej(7)
    arm.k3Hand.movej(8)
    arm.k3Hand.movej(3)
    changeMode(514)
    pos = [-40.04,-5.35,127.41,-55.21,-47.55,-49.88]
    pos = [pos[i]*math.pi/180.0 for i in range(6)]
    pipetthing(arm, 5)
    move_to_pose(pos,op,arm)


if __name__ == "__main__":
    rospy.init_node("get_medium")
    op = Operater()
    arm = Arm()
    changeMode(0)
    arm.controller_connect()
    arm.add_k3hand()
    arm.clear_error()
    get_medium(op,arm)
