import rospy
import tf2_ros
import tf2_geometry_msgs
from geometry_msgs.msg import PoseStamped, PoseArray
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