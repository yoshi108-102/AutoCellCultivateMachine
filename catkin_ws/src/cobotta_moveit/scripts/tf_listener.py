#!/usr/bin/env python3
import rospy
import tf2_ros
import tf2_geometry_msgs
from geometry_msgs.msg import PoseStamped, PoseArray
from visualization_msgs.msg import Marker

trans = None


class TfListener:
    def __init__(self):
        self.buffer = tf2_ros.Buffer()
        self.listener = tf2_ros.TransformListener(self.buffer)

    def posearray_transport(self, posearray, from_frame, to_frame):
        try:
            trans = self.buffer.lookup_transform(from_frame, to_frame, rospy.Time(0))
        except Exception as e:
            rospy.logwarn(e)
            return
        transformed_posearray = PoseArray()
        for i in range(len(posearray.poses)):
            pose = PoseStamped()
            pose.header = posearray.header
            pose.pose = posearray.poses[i]
            transformed_pose = tf2_geometry_msgs.do_transform_pose(pose, trans)
            transformed_posearray.poses.append(transformed_pose.pose)
        return transformed_posearray

    def pose_transport(self, pose, from_frame, to_frame):
        try:
            trans = self.buffer.lookup_transform(to_frame, from_frame, rospy.Time(0))
        except Exception as e:
            rospy.logwarn(e)
            return
        transformed_pose = tf2_geometry_msgs.do_transform_pose(pose, trans)
        return transformed_pose

    def lookupTransform(self, target, source):
        try:
            trans = self.buffer.lookup_transform(target, source, rospy.Time(0))
        except Exception as e:
            rospy.logwarn(e)
            return
        return trans

    def do_transform_pose(self, pose: PoseStamped, from_frame: str, to_frame: str):
        try:
            trans = self.buffer.lookup_transform(
                to_frame, from_frame, rospy.Time(0), rospy.Duration(1.0)
            )
        except Exception as e:
            rospy.logerr(e)
            return
        return tf2_geometry_msgs.do_transform_pose(pose, trans)


if __name__ == "__main__":
    rospy.init_node("tf_listener")
    tf = TfListener()
    pub = rospy.Publisher("marker", Marker, queue_size=10)
    while not rospy.is_shutdown():
        trans = tf.buffer.lookup_transform(
            "base_link", "camera_link", rospy.Time(0), rospy.Duration(1.0)
        )
        marker = Marker()
        pose = PoseStamped()
        pose.header.frame_id = "camera_link"
        pose.pose.position.x = 0.1
        pose.pose.position.y = -0.1
        pose.pose.position.z = 0.23

        pose.header.stamp = rospy.Time.now()
        pose = tf2_geometry_msgs.do_transform_pose(pose, trans)
        rospy.loginfo(pose.pose.position)
        marker = Marker()
        marker.id = 1
        marker.header.frame_id = "base_link"
        marker.header.stamp = rospy.Time.now()
        marker.pose = pose.pose
        marker.pose.orientation.x = 0
        marker.pose.orientation.y = 0
        marker.pose.orientation.z = 0
        marker.pose.orientation.w = 1.0
        marker.type = Marker.SPHERE
        marker.scale.x = 0.05
        marker.scale.y = 0.05
        marker.scale.z = 0.05
        marker.color.g = 1.0
        marker.color.a = 1.0
        pub.publish(marker)
