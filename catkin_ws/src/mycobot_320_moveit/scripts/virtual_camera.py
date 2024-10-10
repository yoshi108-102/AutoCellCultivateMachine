#!/usr/bin/env python3
import rospy
import tf
from tf.transformations import quaternion_from_euler
import tf2_ros
import geometry_msgs.msg
import yaml
import roslib.packages
import math
from geometry_msgs.msg import PoseStamped
from visualization_msgs.msg import Marker


class TfBroadCaster:
    def __init__(self):
        self.dynamicBroadcaster = tf2_ros.TransformBroadcaster()
        self.staticBroadcaster = tf2_ros.StaticTransformBroadcaster()

    def broadcast(self, frame_id, child_frame_id, position, orientation, is_static):
        t = geometry_msgs.msg.TransformStamped()
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


def main():
    rospy.init_node("virtual_camera", anonymous=True)
    pkg_dir = roslib.packages.get_pkg_dir("mycobot_320_moveit")
    yaml_path = pkg_dir + "/config/mycobot_position.yaml"
    with open(yaml_path, "r") as f:
        yml = yaml.safe_load(f)
    x = yml["position"]["x"]
    y = yml["position"]["y"]
    z = yml["position"]["z"]
    tfmaker = TfBroadCaster()
    while not rospy.is_shutdown():
        tfmaker.broadcast("base_link", "camera_pos", [x, y, z], [0, 0, 0], False)
        tfmaker.broadcast(
            "camera_pos", "camera_link", [0, 0, 0], [-math.pi / 2, 0, 0], False
        )
        #lidarの位置はとりあえずカメラと同じものとする
        tfmaker.broadcast("base_link", "livox_frame", [x, y, z], [0, 0, 0], False)
        rospy.sleep(0.1)


if __name__ == "__main__":
    main()
