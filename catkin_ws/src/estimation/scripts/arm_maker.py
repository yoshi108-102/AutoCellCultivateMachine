#!/usr/bin/env python3
import rospy
import moveit_commander
import sys
from geometry_msgs.msg import PoseArray,Quaternion,PoseStamped

def arm_maker(data:PoseArray,scene:moveit_commander.PlanningSceneInterface):
    target = ["RWrist", "RElbow", "RShoulder", "LWrist", "LElbow", "LShoulder"]
    pre_arm = scene.get_known_object_names()
    if pre_arm:
        for object in pre_arm:
            scene.remove_world_object(object)
    radius = 0.03
    for i,pose in enumerate(data.poses):
        if pose.orientation == Quaternion(0,0,0,0):
            continue
        pose_stamp = PoseStamped()
        pose_stamp.pose = pose
        pose_stamp.header.frame_id = "base_link"
        scene.add_sphere(target[i],pose_stamp,radius)
    return
def main():
    rospy.init_node("arm_maker", anonymous=True)
    moveit_commander.roscpp_initialize(sys.argv)
    scene = moveit_commander.PlanningSceneInterface()
    rospy.Subscriber("arm_pose", PoseArray, arm_maker, scene)
    rospy.spin()
if __name__ == "__main__":
    main()