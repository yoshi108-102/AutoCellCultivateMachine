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

def move_to_pose(pos: PoseStamped, op: Operater, arm: Arm):
    is_success = False
    pos.pose.position.y += 0.04
    pos.pose.position.z += 0.02
    x, y, z, w = tf.transformations.quaternion_from_euler(math.pi / 2, math.pi, 0)
    rospy.loginfo((x,y,z,w))
    pos.pose.orientation = Quaternion(x, y, z, w)
    is_success = op.cob_move_to(pose=pos,having_constraint=False)
    return is_success
    """
    TODO:
    掴みやすいようになんかいい感じに回転
    """
def catch_pipette(op: Operater, arm: Arm):
    changeMode(0)
    arm.k3Hand.movej(3)
    rospy.sleep(3)
    arm.k3Hand.movej(0)
    changeMode(514)
    pos = rospy.wait_for_message("object_pose_pipette", PoseStamped)
    while True:
        is_success = move_to_pose(pos=pos,op=op,arm=arm)
        if is_success:
            break
    changeMode(0)
    arm.k3Hand.movej(0)
    arm.k3Hand.movej(1)
    arm.k3Hand.movej(2)
    arm.k3Hand.movej(3)
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
    catch_pipette(op, arm)
    rospy.spin()


if __name__ == "__main__":
    main()
