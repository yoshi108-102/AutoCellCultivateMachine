#!/usr/bin/env python3
import math

import actionlib
import moveit_commander
import rospy
import tf2_geometry_msgs
import tf2_ros
from control_msgs.msg import (FollowJointTrajectoryAction,
                              FollowJointTrajectoryActionGoal)
from geometry_msgs.msg import PoseStamped
from trajectory_msgs.msg import JointTrajectory


class Operater:
    def __init__(self):
        self.buffer = tf2_ros.Buffer()
        self.listener = tf2_ros.TransformListener(self.buffer)
        self.mc_group = moveit_commander.MoveGroupCommander("arm_group")
        self.scene = moveit_commander.PlanningSceneInterface()
        self.cob_group = moveit_commander.MoveGroupCommander("arm")
        self.cob_group.set_max_velocity_scaling_factor(0.8)
        self.target = None
        self.sub = rospy.Subscriber("/object_pose",PoseStamped,self.cb)
        self.mc_joints=[
            'mycobot_arm_joint_0',
            'mycobot_arm_joint_1',
            'mycobot_arm_joint_2',
            'mycobot_arm_joint_3',
            'mycobot_arm_joint_4',
            'mycobot_arm_joint_5'
        ]
        self.cob_joints=[
            'joint_1',
            'joint_2',
            'joint_3',
            'joint_4',
            'joint_5',
            'joint_6'
        ]
        self.cobAvoidTimer = rospy.Timer(rospy.Duration(0.1),self.cob_avoid)
    def cb(self,msg: PoseStamped):
        self.target = msg
    def is_new_topic(self,target):
        if rospy.Time.now() - target.header.stamp > rospy.Duration(0.1):
            return False
        return True
    def mc_move_to(self,pose:PoseStamped) -> bool:
        target = pose
        if target is None:
            return False
        pos = target.pose.position
        self.mc_group.set_position_target([pos.x,pos.y,pos.z,-math.pi/2,0,0])
        try:
            plan = self.mc_group.plan()
        except Exception as e:
            rospy.logwarn(e)
            return
        goal = FollowJointTrajectoryActionGoal()
        goal.goal.trajectory = plan[1].joint_trajectory
        
        client = actionlib.SimpleActionClient('mycobot_arm_controller/follow_joint_trajectory',FollowJointTrajectoryAction)
        client.wait_for_server()
        
        client.send_goal(goal.goal)
        
        client.wait_for_result()
        if client.get_state() == actionlib.GoalStatus.SUCCEEDED:
            rospy.loginfo("Succeeded")
            return True
        else:
            rospy.logwarn("Failed")
            return False
    def cob_move_to(self,pose:PoseStamped) -> bool:
        target = pose
        if target is None:
            return False
        self.cob_group.set_pose_target(target)
        try:
            plan = self.cob_group.plan()
            rospy.loginfo(plan)
            self.cob_group.go(wait=True)
            return True
        except Exception as e:
            rospy.logwarn(e)
            exit(1)
    def cob_avoid(self,event):
        objects = ["hand","wrist"]
        border = 0.1
        end_pose = self.cob_group.get_current_pose()
        #各オブジェクトの位置を取得
        try:
            hand_pose = self.scene.get_object_poses([objects[0]])['hand']
            tmp = PoseStamped()
            tmp.pose = hand_pose
            hand_pose = tmp
        except Exception as e:
            rospy.logwarn(e)
            rospy.loginfo("hand is None")
            return
        try:
            wrist_pose = self.scene.get_object_poses([objects[1]])['wrist']
            tmp = PoseStamped()
            tmp.pose = wrist_pose
            wrist_pose = tmp
        except Exception as e:
            rospy.loginfo("wrist is None")
            return
        hand_distance = self.calc_distance(end_pose,hand_pose)
        arm_distance = self.calc_arm_distance(hand_pose,wrist_pose)
        if min(hand_distance,arm_distance) < 1.0:
            rospy.logwarn("avoid!!!!!!!!!!!")
        rospy.loginfo((hand_distance,arm_distance))
        #腕とエンドエフェクタの距離を計算
    def calc_arm_distance(self,p1,p2):
        end_pose = self.cob_group.get_current_pose()
        
        left = 0
        right = 1
        while right - left > 0.001:
            mid1 = left + (right - left) / 3
            mid2 = right - (right - left) / 3
            pmid1 = self.calc_inter_point(p1,p2,mid1)
            pmid2 = self.calc_inter_point(p1,p2,mid2)
            if self.calc_distance(pmid1,end_pose) < self.calc_distance(pmid2,end_pose):
                right = mid2
            else:
                left = mid1
        return self.calc_distance(self.calc_inter_point(p1,p2,(left+right)/2),end_pose)
    def calc_distance(self,p1:PoseStamped,p2:PoseStamped) -> float:
        return math.sqrt((p1.pose.position.x - p2.pose.position.x)**2 + (p1.pose.position.y - p2.pose.position.y)**2 + (p1.pose.position.z - p2.pose.position.z)**2)
    def calc_inter_point(self,p1,p2,t):
        p1x,p1y,p1z = p1.pose.position.x,p1.pose.position.y,p1.pose.position.z
        p2x,p2y,p2z = p2.pose.position.x,p2.pose.position.y,p2.pose.position.z
        x = p1x + (p2x - p1x) * t
        y = p1y + (p2y - p1y) * t
        z = p1z + (p2z - p1z) * t
        new_pose = PoseStamped()
        new_pose.pose.position.x = x
        new_pose.pose.position.y = y
        new_pose.pose.position.z = z
        return new_pose
def main():
    rospy.init_node('operater')
    op = Operater()
    rospy.spin()
if __name__ == "__main__":
    main()