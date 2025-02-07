#!/usr/bin/env python3

from functools import partial

import rospy
from geometry_msgs.msg import PoseStamped
from virtual_camera import TfBroadCaster
from visualization_msgs.msg import Marker

x = 0
y = 0
z = 0


def callback(pub, data: PoseStamped):
    global x, y, z
    if (rospy.Time.now() - data.header.stamp).to_sec() > 0.1:
        return
    marker = Marker()
    marker.id = 0
    marker.header.stamp = rospy.Time.now()
    marker.header.frame_id = "mycobot_base_link"

    marker.pose = data.pose

    marker.pose.orientation.x = 0
    marker.pose.orientation.y = 0
    marker.pose.orientation.z = 0
    marker.pose.orientation.w = 1.0

    marker.type = Marker.SPHERE

    marker.scale.x = 0.05
    marker.scale.y = 0.05
    marker.scale.z = 0.05

    marker.color.r = 1.0
    marker.color.a = 1.0

    pub.publish(marker)
    marker.lifetime = rospy.Duration(0.3)


print("Subscribing to target_estimation topic...")
rospy.init_node("marker_display", anonymous=True)
pub = rospy.Publisher("visualization_marker", Marker, queue_size=20)

rospy.Subscriber("object_pose_medium0", PoseStamped, partial(callback, pub))
rospy.Subscriber("object_pose_medium1", PoseStamped, partial(callback, pub))
rospy.Subscriber("object_pose_dish", PoseStamped, partial(callback, pub))
rospy.Subscriber("object_pose_pipette", PoseStamped, partial(callback, pub))

while not rospy.is_shutdown():
    rospy.spin()

""" tf_broadcaster = TfBroadCaster()
while not rospy.is_shutdown():
    tf_broadcaster.broadcast(
        "camera_link",
        "Head",
        [x, y, z],
        [0, 0, 0],
        is_static=False,
    ) """
