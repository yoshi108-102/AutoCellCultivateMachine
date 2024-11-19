#!/usr/bin/env python3
import rospy
from std_msgs.msg import String
rospy.init_node('namespace')

pub = rospy.Publisher('namespace', String, queue_size=10)

while not rospy.is_shutdown():
    pub.publish('namespace')
    rospy.sleep(0.1)