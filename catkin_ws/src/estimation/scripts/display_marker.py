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


def callback(pub, data: PoseStamped):
    global x, y, z
    if (rospy.Time.now() - data.header.stamp).to_sec() > 0.1:
        return
    marker = Marker()
    marker.header.frame_id = "Head"
    marker.header.stamp = rospy.Time.now()
    marker.ns = "Head"
    marker.id = 0
    marker.action = Marker.ADD

    marker.pose.orientation.x = 0
    marker.pose.orientation.y = 0
    marker.pose.orientation.z = 0
    marker.pose.orientation.w = 1.0

    marker.type = Marker.SPHERE

    marker.scale.x = 0.05
    marker.scale.y = 0.05
    marker.scale.z = 0.05

    if data.header.frame_id == "PipetteHead":
        marker.color.r = 1.0
    else:
        marker.color.g = 1.0

    x, y, z = data.pose.position.x, data.pose.position.y, data.pose.position.z
    pub.publish(marker)
    marker.lifetime = rospy.Duration(0.3)


print("Subscribing to target_estimation topic...")
rospy.init_node("marker_display", anonymous=True)
pub = rospy.Publisher("visualization_marker", Marker, queue_size=20)
print("Hello")

rospy.Subscriber("target_estimation", PoseStamped, partial(callback, pub))
while not rospy.is_shutdown():
    tf.TransformBroadcaster().sendTransform(
        (x, y, z),
        quaternion_from_euler(math.pi / 2, 0, 0),
        rospy.Time.now(),
        "Head",
        "camera_link",
    )
    rospy.sleep(0.1)
