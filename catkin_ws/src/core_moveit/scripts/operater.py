#!/usr/bin/env python3
import rospy 
from trajectory_msgs.msg import JointTrajectory
from geometry_msgs.msg import PoseStamped
import moveit_commander
import actionlib
import tf2_ros
import tf2_geometry_msgs
import math
from control_msgs.msg import FollowJointTrajectoryAction,FollowJointTrajectoryActionGoal
class Operater:
    def __init__(self):
        self.buffer = tf2_ros.Buffer()
        self.listener = tf2_ros.TransformListener(self.buffer)
        self.mc_group = moveit_commander.MoveGroupCommander("arm_group")
        self.cob_group = moveit_commander.MoveGroupCommander("arm")
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
        pos = target.pose.position
        self.cob_group.set_position_target([pos.x,pos.y,pos.z])
        try:
            plan = self.cob_group.plan()
            rospy.loginfo(plan)
            self.cob_group.go(wait=True)
            return True
        except Exception as e:
            rospy.logwarn(e)
            exit(1)
def main():
    rospy.init_node('operater')
    operater = Operater()
    while not rospy.is_shutdown():
        operater.mc_move_to()
if __name__ == "__main__":
    main()