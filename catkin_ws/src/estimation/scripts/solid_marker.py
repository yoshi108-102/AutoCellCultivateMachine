#!/usr/bin/env python3
import random

import rospy
from geometry_msgs.msg import PoseStamped, Quaternion


def medium_marker(num) -> PoseStamped:
    pose_list = [
        [-0.10,-0.05,0.16],
        [-0.10,-0.05,0.30]
    ]
    pose = PoseStamped()
    pose.header.frame_id = f"medium{num}"
    pose.pose.position.x = pose_list[num][0]
    pose.pose.position.y = pose_list[num][1]
    pose.pose.position.z = pose_list[num][2]
    pose.pose.orientation = Quaternion(0,0,0,1)

    pose.header.stamp = rospy.Time.now()
    return pose


def main():
    rospy.init_node("target_estimation", anonymous=True)
    pub = rospy.Publisher("target_estimation", PoseStamped, queue_size=10)
    while not rospy.is_shutdown():
        for i in range(2):
            pub.publish(medium_marker(i))


if __name__ == "__main__":
    main()
