#!/usr/bin/env python3
import math
import sys
import time

import geometry_msgs.msg
import moveit_commander
import rospy
import tf
from pymycobot.mycobot import MyCobot
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint

mc = None


"""
-pi/6で閉じます
pi/6で開きます
radians[5]はこの区間くらいで動かすこと！
"""


def mc_send_radians(radians, arm_pub, speed=100):
    # Create JointTrajectory message
    global mc
    trajectory_msg = JointTrajectory()
    trajectory_msg.joint_names = [
        "arm_joint_0",
        "arm_joint_1",
        "arm_joint_2",
        "arm_joint_3",
        "arm_joint_4",
        "arm_joint_5",
    ]
    point_msg = JointTrajectoryPoint()

    # Set joint angles
    point_msg.positions = radians

    # Set other fields of the JointTrajectory message
    point_msg.time_from_start = rospy.Duration(1.0 * 100 / speed)
    trajectory_msg.points.append(point_msg)

    # Publish JointTrajectory message
    rospy.loginfo("Publishing JointTrajectory message...")
    arm_pub.publish(trajectory_msg)
    if mc is not None:
        rospy.loginfo(radians)
        mc.send_radians(radians, speed=speed)
        now_pos = mc.get_coords()
        rospy.loginfo(now_pos)
    rospy.loginfo("Done.")


def rotate_end_effector(deg, arm_pub, move_group):
    global mc
    do_jo = move_group.get_current_joint_values()
    do_jo[5] = math.pi * deg / 180
    mc_send_radians(do_jo, arm_pub, 50)
    time.sleep(6)


def end_effector_pose(
    x, y, z, deg, arm_pub, move_group: moveit_commander.MoveGroupCommander
):
    try:
        move_group.set_pose_target([x, y, z, -math.pi, 0, 0])
        p = move_group.plan()
        tar_jo = list(p[1].joint_trajectory.points[-1].positions)
        tar_jo[5] = math.pi * deg / 180
        mc_send_radians(tar_jo, arm_pub, 100)
        # rospy.sleep(0.1)
    except Exception as e:
        rospy.loginfo("Failed to move end effector")


def main():
    # Initialize ROS node
    rospy.init_node("joint_controller")

    # Create node handle
    arm_pub = rospy.Publisher("/arm_controller/command", JointTrajectory, queue_size=10)

    # Initialize moveit_commander
    moveit_commander.roscpp_initialize(sys.argv)
    move_group = moveit_commander.MoveGroupCommander("arm_group")
    move_group.set_planning_time(0.03)
    listener = tf.listener.TransformListener()
    is_catched = False
    global mc
    try:
        port = rospy.get_param("~port", "/dev/ttyUSB0")
        baud = rospy.get_param("~baud", 115200)
        print(port, baud)
        mc = MyCobot(port, baud)
        time.sleep(0.05)
        mc.set_free_mode(1)
        time.sleep(0.05)
        mc.send_radians([0, 0, 0, 0, 0, math.pi / 2], speed=50)
        time.sleep(0.5)
    except Exception as e:
        rospy.logwarn(e)
    for i in range(5):
        while not rospy.is_shutdown():
            try:
                listener.waitForTransform(
                    "base_link", "pipette", rospy.Time(0), rospy.Duration(0.03)
                )
                pos = listener.lookupTransform("base_link", "pipette", rospy.Time(0))
                rospy.loginfo(pos)
                break
            except Exception as e:
                rospy.logwarn(e)
        end_effector_pose(
            pos[0][0] - 0.02, pos[0][1], pos[0][2] + 0.04, 30, arm_pub, move_group
        )
        rospy.sleep(2)
        radians = mc.get_radians()
        radians[5] = -math.pi / 6
        mc.send_radians(radians, 30)
        rospy.sleep(0.2)
        radians[5] = math.pi / 6
        mc.send_radians(radians, 30)
        rospy.sleep(0.2)


if __name__ == "__main__":
    main()
