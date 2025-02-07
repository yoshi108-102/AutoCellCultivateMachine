#!/usr/bin/env python3
import random

import rospy
from geometry_msgs.msg import PoseStamped, Quaternion


def pipette_marker() -> PoseStamped:
    pose = PoseStamped()
    pose.header.frame_id = "pipette"
    pose.pose.position.x = -0.3
    pose.pose.position.y = -0.1
    pose.pose.position.z = 0.2
    pose.pose.orientation = Quaternion(0,0,0,1)

    pose.header.stamp = rospy.Time.now()
    return pose
def dish_marker() -> PoseStamped:
    pose = PoseStamped()
    pose.header.frame_id = "dish"
    pose.pose.position.x = 0
    pose.pose.position.y = 0.1
    pose.pose.position.z = 0.53
    pose.header.stamp = rospy.Time.now()
    return pose


def main():
    rospy.init_node("target_estimation", anonymous=True)
    pub = rospy.Publisher("target_estimation", PoseStamped, queue_size=10)
    while not rospy.is_shutdown():
        #pub.publish(pipette_marker())
        #pub.publish(dish_marker())
        pass


if __name__ == "__main__":
    main()
