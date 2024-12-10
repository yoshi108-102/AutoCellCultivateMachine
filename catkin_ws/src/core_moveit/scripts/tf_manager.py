#!/usr/bin/env python3
import rospy
from tf.transformations import quaternion_from_euler
import tf2_ros
from geometry_msgs.msg import PoseStamped
from geometry_msgs.msg import TransformStamped
import yaml
import tf2_geometry_msgs
class TfBroadCaster:
    def __init__(self):
        self.dynamicBroadcaster = tf2_ros.TransformBroadcaster()
        self.staticBroadcaster = tf2_ros.StaticTransformBroadcaster()
        self.objectTfSetter = rospy.Subscriber('target_estimation', PoseStamped, self.set_object_tf)
        self.camera_trans = None
        self.buffer = tf2_ros.Buffer()
        self.listener = tf2_ros.TransformListener(self.buffer)
    def broadcast(self, frame_id, child_frame_id, position, orientation, is_static):
        t = TransformStamped()
        t.header.stamp = rospy.Time.now()
        t.header.frame_id = frame_id
        t.child_frame_id = child_frame_id
        t.transform.translation.x = position[0]
        t.transform.translation.y = position[1]
        t.transform.translation.z = position[2]
        q = quaternion_from_euler(orientation[0], orientation[1], orientation[2])
        t.transform.rotation.x = q[0]
        t.transform.rotation.y = q[1]
        t.transform.rotation.z = q[2]
        t.transform.rotation.w = q[3]
        if is_static:
            self.staticBroadcaster.sendTransform(t)
        else:
            self.dynamicBroadcaster.sendTransform(t)
    def get_camera_trans(self):
        try:
            self.camera_trans = self.buffer.lookup_transform(target_frame="mycobot_base_link",
                                                    source_frame="camera_link",
                                                    time=rospy.Time(0))
        except Exception as e:
            rospy.logwarn(e)
            return
    def set_object_tf(self, msg:PoseStamped):
        if self.camera_trans is None:
            self.get_camera_trans()
        #self.camera_trans.header.stamp = rospy.Time.now()
        new_pos = tf2_geometry_msgs.do_transform_pose(msg, self.camera_trans)
        new_pos.header = msg.header
        new_pos.header.stamp = rospy.Time.now()
        rospy.Publisher('object_pose', PoseStamped, queue_size=10).publish(new_pos)
        

def main():
    rospy.init_node('tf_manager')
    tf_broadcaster = TfBroadCaster()
    tf_data = rospy.get_param('~tf_data')
    tf_data:dict = yaml.safe_load(tf_data)
    rospy.loginfo(type(tf_data))
    while not rospy.is_shutdown():
        for k in tf_data.keys():
            data = tf_data[k]
            parent = data['parent']
            pos = data['pos']
            rpy = data['rpy']
            tf_broadcaster.broadcast(parent, k, pos, rpy, False)
            rospy.sleep(0.01)
        


if __name__ == "__main__":
    main()
