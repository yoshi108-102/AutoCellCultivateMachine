#!/usr/bin/env python3
import math
import sys

import moveit_commander
import rospy
import tf
from geometry_msgs.msg import Pose, PoseArray, PoseStamped, Quaternion


class Planner:
    def __init__(self):
        self.planner = moveit_commander.PlanningSceneInterface()
        self.handSub = rospy.Subscriber('/hand_pose',PoseArray,self.add_hand)
    def add_hand(self,msg:PoseArray):
        self.planner.remove_attached_object()
        center = PoseStamped()
        for p in msg.poses:
            center.pose.position.x += p.position.x
            center.pose.position.y += p.position.y
            center.pose.position.z += p.position.z
        center.pose.position.x /= len(msg.poses)
        center.pose.position.y /= len(msg.poses)
        center.pose.position.z /= len(msg.poses)
        self.add_sphere(center,0.03)
        self.add_cylinder(msg.poses[0],center.pose,0.03)
        rospy.loginfo(self.planner.get_known_object_names())
    def add_sphere(self,center:PoseStamped,radius:float):
        self.planner.add_sphere('hand',center,radius)
    
    def add_cylinder(self,start:Pose,end:Pose,radius:float):
        center = PoseStamped()
        #centerはstartとendの中点
        center.pose.position.x = (start.position.x + end.position.x)/2
        center.pose.position.y = (start.position.y + end.position.y)/2
        center.pose.position.z = (start.position.z + end.position.z)/2
        #startとendのベクトル方向に円柱を回転
        #startからendへのベクトル
        vec = PoseStamped()
        vec.pose.position.x = end.position.x - start.position.x
        vec.pose.position.y = end.position.y - start.position.y
        vec.pose.position.z = end.position.z - start.position.z
        length = math.sqrt(vec.pose.position.x**2 + vec.pose.position.y**2 + vec.pose.position.z**2)
        rospy.loginfo([x/length for x in [vec.pose.position.x,vec.pose.position.y,vec.pose.position.z]])
        #円柱の向き
        r = 0
        p = math.atan2(vec.pose.position.y,vec.pose.position.x)
        y = math.atan2(vec.pose.position.z,length)
        
        q = tf.transformations.quaternion_from_euler(r,p,y)

        center.pose.orientation = Quaternion(q[0],q[1],q[2],q[3])
        self.planner.add_cylinder('arm',center,radius,length)

if __name__ == '__main__':
    rospy.init_node('planner')
    moveit_commander.roscpp_initialize(sys.argv)
    planner = Planner()
    rospy.spin()