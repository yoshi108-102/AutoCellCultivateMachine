#!/usr/bin/env python3
import math
import sys
import time

import geometry_msgs.msg
import moveit_commander
import rospy
import tf
from geometry_msgs.msg import PoseStamped
from pymycobot.mycobot import MyCobot
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint


def main():
    # Initialize ROS node
    rospy.init_node("joint_controller")

    # Create node handle
    rospy.Subscriber()

    scene = moveit_commander.PlanningSceneInterface()
    rospy.sleep(2)
    box_pose = PoseStamped()

    # Initialize moveit_commander
    moveit_commander.roscpp_initialize(sys.argv)
    move_group = moveit_commander.MoveGroupCommander("arm_group")
    move_group.set_planning_time(0.03)

    box_pose.header.frame_id = move_group.get_planning_frame()
    box_pose.pose.position.x = 0.15
    box_pose.pose.position.y = -0.1
    box_pose.pose.position.z = 0.25
    box_pose.pose.orientation.w = 1.0
    scene.add_box("box_object", box_pose, (0.05, 0.2, 0.03))
