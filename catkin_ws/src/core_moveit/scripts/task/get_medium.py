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
from change_mode import changeMode
from cobotta.cobotta_arm import CobottaArmBcapInterface as Arm
from geometry_msgs.msg import Quaternion
from operater import Operater
from std_msgs.msg import Int32
from .pipetthing import pipetthing
"""
1. ピペットにアームを十分に近づける
2. 適切にアームを回転させる
3. ピペットを把持する
"""


def move_to_pose(pos: PoseStamped, op: Operater, arm: Arm):
    is_success = False
    
    x, y, z, w = tf.transformations.quaternion_from_euler(math.pi / 2, math.pi, 0)
    rospy.loginfo((x,y,z,w))
    pos.pose.orientation = Quaternion(x, y, z, w)
    while not is_success:
        is_success = op.cob_move_to(pose=pos)
    """
    TODO:
    掴みやすいようになんかいい感じに回転
    """

def get_medium(op:Operater,arm:Arm):
    import rospy
    rospy.init_node("catch_pipette")
    moveit_commander.roscpp_initialize(sys.argv)
    changeMode(514)
    pos = rospy.wait_for_message("object_pose_medium0", PoseStamped)
    move_to_pose(pos,op,arm)
    changeMode(0)
    arm.k3Hand.movej(3)
    # 1.ピペットの先端にアームの指先を移動
    arm.k3Hand.movej(4)
    arm.k3Hand.movej(8)
    arm.k3Hand.movej(7)
    arm.k3Hand.movej(6)
    changeMode(514)
    pos = rospy.wait_for_message("object_pose_medium1", PoseStamped)
    move_to_pose(pos,op,arm)
    changeMode(0)
    arm.k3Hand.movej(5)
    rospy.sleep(1)
    arm.k3Hand.movej(7)
    arm.k3Hand.movej(8)
    arm.k3Hand.movej(3)
    changeMode(514)
    pos = rospy.wait_for_message("object_pose_medium0", PoseStamped)
    pipetthing(arm, 5)
    move_to_pose(pos,op,arm)
    rospy.spin()


if __name__ == "__main__":
    op = Operater()
    arm = Arm()
    changeMode(0)
    arm.controller_connect()
    arm.add_k3hand()
    arm.clear_error()
    get_medium(op,arm)
