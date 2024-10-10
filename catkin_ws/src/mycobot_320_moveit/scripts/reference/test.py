#!/usr/bin/env python3
# coding=utf-8
import time
import rospy
import math
import numpy as np

import sys
import moveit_commander

import rospy
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint

# Initialize ROS node
rospy.init_node("joint_controller")

# Create node handle
arm_pub = rospy.Publisher("/arm_controller/command", JointTrajectory, queue_size=10)

# Initialize moveit_commander
moveit_commander.roscpp_initialize(sys.argv)
move_group = moveit_commander.MoveGroupCommander("arm_group")


def mc_send_radians(radians, speed=100):
    # Create JointTrajectory message
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
    rospy.loginfo("Done.")


def mc_send_angles(angles, speed=100):
    radians = [math.radians(angle) for angle in angles]
    mc_send_radians(radians, speed)


def end_effector_pose(x, y, z, deg):
    global move_group
    move_group.set_pose_target([x, y, z, -math.pi, 0, 0])
    p = move_group.plan()
    tar_jo = list(p[1].joint_trajectory.points[-1].positions)
    tar_jo[5] = math.pi * deg / 180
    mc_send_radians(tar_jo, 50)
    time.sleep(3)


def rotate_end_effector(deg):
    global move_group
    do_jo = move_group.get_current_joint_values()
    do_jo[5] = math.pi * deg / 180
    mc_send_radians(do_jo, 50)
    time.sleep(6)


def pick_up():
    global move_group
    move_group.set_goal_position_tolerance(0.00001)
    move_group.set_goal_orientation_tolerance(0.00001)

    mc_send_angles([0, 0, 0, 0, 0, 0], 50)
    time.sleep(2)
    mc_send_angles([0, 0, 0, 0, 0, 0], 50)
    time.sleep(2)

    up = 0.12
    do = 0.05

    x = 0.24
    y = -0.065
    while True:

        end_effector_pose(x, y, up, -140)
        end_effector_pose(x, y, up, -140)
        # cu_jo = move_group.get_current_joint_values()

        # print(cu_jo)

        end_effector_pose(x, y, do, -140)

        rotate_end_effector(-165)

        end_effector_pose(x, y, up, -165)

        time.sleep(3)

        i = input("continue?")
        if i == "n":
            rotate_end_effector(-140)
            break
        else:
            continue
    mc_send_angles([0, 0, 0, 0, 0, 0], 50)


if __name__ == "__main__":
    pick_up()
    rospy.signal_shutdown("Program ended.")
