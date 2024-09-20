#!/usr/bin/env python3
import moveit_commander
import rospy
import geometry_msgs.msg
import sys
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
import tf
import math
from pymycobot.mycobot import MyCobot
import time
from geometry_msgs.msg import PoseStamped
mc = None
def mc_send_radians(radians,arm_pub, speed=100):
    # Create JointTrajectory message
    global mc
    trajectory_msg = JointTrajectory()
    trajectory_msg.joint_names = ["arm_joint_0", "arm_joint_1", "arm_joint_2", "arm_joint_3", "arm_joint_4", "arm_joint_5"]
    point_msg = JointTrajectoryPoint()

    # Set joint angles
    point_msg.positions = radians

    # Set other fields of the JointTrajectory message
    point_msg.time_from_start = rospy.Duration(1.0*100 / speed)
    trajectory_msg.points.append(point_msg)

    # Publish JointTrajectory message
    rospy.loginfo("Publishing JointTrajectory message...")
    arm_pub.publish(trajectory_msg)
    if mc is not None:
        mc.send_radians(radians, speed=speed)
        now_pos = mc.get_coords()
    rospy.loginfo("Done.")
def end_effector_pose(x, y, z, deg,arm_pub,move_group: moveit_commander.MoveGroupCommander):
    try:
        move_group.set_pose_target([x, y, z, -math.pi, 0, 0])
        p = move_group.plan()
        tar_jo = list(p[1].joint_trajectory.points[-1].positions)
        tar_jo[5] = math.pi * deg/ 180
        mc_send_radians(tar_jo,arm_pub, 70)
        #rospy.sleep(0.1)
    except Exception as e:
        rospy.loginfo("Failed to move end effector")
def main():
    # Initialize ROS node
    rospy.init_node('joint_controller')

    # Create node handle
    arm_pub = rospy.Publisher('/arm_controller/command', JointTrajectory, queue_size=10)

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
    scene.add_box('box_object',box_pose,(0.05,0.2,0.03))
    
    rospy.loginfo("Scene Objects: {}".format(scene.get_known_object_names()))
    listener = tf.listener.TransformListener()
    global mc
    try:
        port = rospy.get_param("~port", "/dev/ttyUSB1")
        baud = rospy.get_param("~baud", 115200)
        print(port, baud)
        mc = MyCobot(port, baud)
        time.sleep(0.05)
        mc.set_free_mode(1)
        time.sleep(0.05)
        mc.send_radians([0, 0, 0, 0, 0, 0], speed=50)
    except Exception as e:
        rospy.logwarn(e)
    while not rospy.is_shutdown():
        try:
            listener.waitForTransform("base_link","Head",rospy.Time(0),rospy.Duration(0.03))
            pos = listener.lookupTransform("base_link","Head",rospy.Time(0))
        except Exception as e:
            rospy.logwarn(e)
            continue
        end_effector_pose(pos[0][0]-0.02,pos[0][1],pos[0][2]+0.02,0,arm_pub,move_group)
if __name__ == '__main__':
    main()