#!/usr/bin/env python3
from tf.transformations import quaternion_from_euler
import rospy
from geometry_msgs.msg import PoseStamped
from visualization_msgs.msg import Marker
from functools import partial
import tf
import math
x = 0
y = 0
z = 0
def callback(pub, data):
    global x,y,z
    marker = Marker()
    marker.header.frame_id = "text"
    marker.header.stamp = rospy.Time.now()
    marker.ns = "text"
    marker.id = 0
    marker.action = Marker.ADD
    
    marker.pose.orientation.x = 0
    marker.pose.orientation.y = 0
    marker.pose.orientation.z = 0
    marker.pose.orientation.w = 1.0
    
    marker.type = Marker.TEXT_VIEW_FACING
    
    marker.scale.x = 0.05
    marker.scale.y = 0.05
    marker.scale.z = 0.05
    
    marker.color.a = 1.0
    marker.color.r = 1.0
    marker.color.g = 1.0
    marker.color.b = 1.0
    
    x,y,z = data.pose.position.x,data.pose.position.y,data.pose.position.z
    x,y,z = round(x,3),round(y,3),round(z,3)
    pub.publish(marker)
    marker.text = "Distance from the Robot\n"+"X [m]: " + str(x) + "\nY [m]: " + str(y) + "\nZ [m]: " + str(z)
    marker.lifetime = rospy.Duration(0.3)
    pub.publish(marker)
rospy.init_node('distance_display', anonymous=True)
listener = tf.listener.TransformListener()
pub = rospy.Publisher('visualization_marker', Marker, queue_size=20)

while not rospy.is_shutdown():
    tf.TransformBroadcaster().sendTransform((-0.1,0,0.3),quaternion_from_euler(0,0,0),rospy.Time.now(),"text","Head")
    try:
        listener.waitForTransform("base_link","Head",rospy.Time(),rospy.Duration(4.0))
        pos = listener.lookupTransform("base_link","Head",rospy.Time(0))
        pose = PoseStamped()
        pose.header.stamp = rospy.Time.now()
        pose.header.frame_id = "link6"
        pose.pose.position.x = pos[0][0]
        pose.pose.position.y = pos[0][1]
        pose.pose.position.z = pos[0][2]
        pose.pose.orientation.x = 0
        pose.pose.orientation.y = 0
        pose.pose.orientation.z = 0
        pose.pose.orientation.w = 1.0
        callback(pub,pose)
    except Exception as e:
        rospy.loginfo(e)
    rospy.sleep(0.1)


