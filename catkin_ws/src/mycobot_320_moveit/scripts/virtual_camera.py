#!/usr/bin/env python3
import rospy
import tf
from tf.transformations import quaternion_from_euler
import yaml
import roslib.packages
import math
from geometry_msgs.msg import PoseStamped
from visualization_msgs.msg import Marker
def marker():
    marker = Marker()
    marker.header.frame_id = "camera_link"
    marker.header.stamp = rospy.Time.now()
    marker.ns = "camera"
    marker.id = 0
    marker.action = Marker.ADD
    marker.pose = PoseStamped().pose
    marker.pose.orientation.x = 0
    marker.pose.orientation.y = 0
    marker.pose.orientation.z = 0
    marker.pose.orientation.w = 1.0
    marker.scale.x = 0.1
    marker.scale.y = 0.1
    marker.scale.z = 0.1
    marker.color.a = 1.0
    marker.color.r = 1.0
    marker.color.g = 1.0
    marker.color.b = 0.0
    marker.type = Marker.SPHERE
    marker.lifetime = rospy.Duration(0)
    return marker
def main():
    rospy.init_node('virtual_camera', anonymous=True)
    pkg_dir = roslib.packages.get_pkg_dir("mycobot_320_moveit")
    yaml_path = pkg_dir + "/config/mycobot_position.yaml"
    with open(yaml_path,'r') as f:
        yml = yaml.safe_load(f)
    x = yml["position"]["x"]
    y = yml["position"]["y"]
    z = yml["position"]["z"]
    pub = rospy.Publisher("visualization_marker", Marker, queue_size=10)
    
    while not rospy.is_shutdown():
        tf.TransformBroadcaster().sendTransform((x,y,z),quaternion_from_euler(0,0,0),rospy.Time.now(),"camera_pos","base_link")
        tf.TransformBroadcaster().sendTransform((0,0,0),quaternion_from_euler(-math.pi/2,0,0),rospy.Time.now(),"camera_link","camera_pos")
        rospy.sleep(0.1)
if __name__ == "__main__":
    main()