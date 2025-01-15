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
from moveit_msgs.msg import (Constraints, JointConstraint, JointLimits,
                             OrientationConstraint, RobotTrajectory)
from sensor_msgs.msg import JointState
from std_msgs.msg import String
from trajectory_msgs.msg import JointTrajectory


class Operater:
    def __init__(self):
        self.buffer = tf2_ros.Buffer()
        self.listener = tf2_ros.TransformListener(self.buffer)
        self.mc_group = moveit_commander.MoveGroupCommander("arm_group")
        self.scene = moveit_commander.PlanningSceneInterface()
        self.cob_group = moveit_commander.MoveGroupCommander("arm")
        self.mc_joint_pub = rospy.Publisher("/joint_command",JointState,queue_size=1)
        self.cob_group.set_max_velocity_scaling_factor(0.8)
        self.cob_group.set_goal_orientation_tolerance(0.03)
        self.cob_group.set_goal_position_tolerance(0.01)
        self.target = None
        self.is_cob_active = False
        self.is_mc_active = False
        self.sub = rospy.Subscriber("/object_pose", PoseStamped, self.cb)
        self.mc_joints = [
            "mycobot_arm_joint_0",
            "mycobot_arm_joint_1",
            "mycobot_arm_joint_2",
            "mycobot_arm_joint_3",
            "mycobot_arm_joint_4",
            "mycobot_arm_joint_5",
        ]
        self.cob_joints = [
            "joint_1",
            "joint_2",
            "joint_3",
            "joint_4",
            "joint_5",
            "joint_6",
        ]
        self.cob_group.set_workspace([-0.2,-0.1,0.0,0.4,0.3,0.56])
        self.mc_group.set_workspace([-0.2,-0.1,0.0,0.4,0.3,0.5])
        self.pre_hand = PoseStamped()
        self.pre_wrist = PoseStamped()
        #self.cobAvoidTimer = rospy.Timer(rospy.Duration(0.4), self.mc_avoid)
    def cb(self, msg: PoseStamped):
        self.target = msg

    def is_new_topic(self, target):
        if rospy.Time.now() - target.header.stamp > rospy.Duration(0.1):
            return False
        return True

    def mc_move_to(self, pose: PoseStamped) -> bool:
        target = pose
        if target is None:
            return False
        pos = target.pose.position
        self.mc_group.set_pose_target(pose)
        try:
            plan = self.mc_group.plan()
        except Exception as e:
            rospy.logwarn(e)
            return
        goal = FollowJointTrajectoryActionGoal()
        goal.goal.trajectory = plan[1].joint_trajectory
        #goal.goal.trajectory.points = goal.goal.trajectory.points[:3]
        rospy.loginfo(goal)
        client = actionlib.SimpleActionClient(
            "mycobot_arm_controller/follow_joint_trajectory",
            FollowJointTrajectoryAction,
        )
        client.wait_for_server()

        client.send_goal(goal.goal)

        client.wait_for_result()
        if client.get_state() == actionlib.GoalStatus.SUCCEEDED:
            rospy.loginfo("Succeeded")
            return True
        else:
            rospy.logwarn("Failed")
            return False
    def mc_send_angles(self,joint_list):
        joint_state = JointState()
        joint_state.position = joint_list
        joint_state.name = [f"joint_{i}" for i in range(6)]
        rospy.loginfo(joint_state)
        self.mc_joint_pub.publish(joint_state)
    def cob_move_to(self, pose: PoseStamped) -> bool:
        current_pose = self.cob_group.get_current_joint_values()
        print(current_pose)
        joint_const = JointConstraint()
        joint_const.joint_name = "joint_6"
        joint_const.position = current_pose[5]
        joint_const.tolerance_above = 2.2
        joint_const.tolerance_below = 2.2
        joint_const.weight = 1.0
        constraints = Constraints()
        constraints.joint_constraints.append(joint_const)
        self.cob_group.set_path_constraints(constraints)
        target = pose
        if target is None:
            return False
        self.cob_group.set_pose_target(target)
        try:
            plan = self.cob_group.plan()
            rospy.loginfo(plan)
            self.is_cob_active = True
            self.cob_group.go(wait=True)
            self.cob_group.stop()
            self.is_cob_active = False
            return True
        except Exception as e:
            rospy.logwarn(e)
            self.is_cob_active = False
            exit(1)
        self.cob_group.clear_path_constraints()
    def cob_cartesian_path(self,pose):
        target = pose
        if target is None:
            return False
        try:
            plan,_ = self.cob_group.compute_cartesian_path([target.pose],0.01)

            rospy.loginfo(plan)
            self.is_cob_active = True
            self.cob_group.go(wait=True)
            self.cob_group.stop()
            self.is_cob_active = False
            return True
        except Exception as e:
            rospy.logwarn(e)
            self.is_cob_active = False
            exit(1)
    def mc_avoid(self,event):
        if self.is_mc_active:
            return
        
        objects = ["hand", "arm_end"]
        border = 0.200
        end_pose = self.cob_group.get_current_pose()
        # 各オブジェクトの位置を取得
        try:
            hand_pose = self.scene.get_object_poses([objects[0]])["hand"]
            tmp = PoseStamped()
            tmp.pose = hand_pose
            hand_pose = tmp
        except Exception as e:
            rospy.logwarn(e)
            rospy.loginfo("hand is None")
            return
        try:
            wrist_pose = self.scene.get_object_poses([objects[1]])["arm_end"]
            tmp = PoseStamped()
            tmp.pose = wrist_pose
            wrist_pose = tmp
        except Exception as e:
            rospy.loginfo("wrist is None")
            return
        self.is_mc_active = True
        hand_distance = self.calc_distance(end_pose, hand_pose)
        arm_distance, t = self.calc_arm_distance(hand_pose, wrist_pose)
        """ if hand_distance < border or arm_distance < border:
            self.cob_group.set_random_target()
            self.cob_group.plan()
            self.cob_group.go(wait=True)
            rospy.loginfo("hand is too close") """
        if hand_distance < border:
            rospy.loginfo("hand is too close")
            target = PoseStamped()
            target.pose.position.x = (
                end_pose.pose.position.x
                + (end_pose.pose.position.x - hand_pose.pose.position.x) * 0.05
            )
            target.pose.position.y = (
                end_pose.pose.position.y
                + (end_pose.pose.position.y - hand_pose.pose.position.y) * 0.05
            )
            target.pose.position.z = (
                end_pose.pose.position.z
                + (end_pose.pose.position.z - hand_pose.pose.position.z) * 0.05
            )
            if not self.is_cob_active:
                self.mc_move_to(target)
        elif arm_distance < border:
            rospy.loginfo("arm is too close")
            target = PoseStamped()
            target.pose.position.x = (
                end_pose.pose.position.x
                + (end_pose.pose.position.x - wrist_pose.pose.position.x) * 0.02
            )
            target.pose.position.y = (
                end_pose.pose.position.y
                + (end_pose.pose.position.y - wrist_pose.pose.position.y) * 0.02
            )
            target.pose.position.z = (
                end_pose.pose.position.z
                + (end_pose.pose.position.z - wrist_pose.pose.position.z) * 0.02
            )
            if not self.is_cob_active:
                self.mc_move_to(target)
        rospy.loginfo((hand_distance, arm_distance))
        rospy.Publisher("/signal", String, queue_size=1).publish("mc_avoid")
        rospy.sleep(2)
        self.is_mc_active = False
    def cob_avoid(self, event):
        objects = ["hand", "arm_end"]
        border = 0.200
        end_pose = self.cob_group.get_current_pose()
        # 各オブジェクトの位置を取得
        try:
            hand_pose = self.scene.get_object_poses([objects[0]])["hand"]
            tmp = PoseStamped()
            tmp.pose = hand_pose
            hand_pose = tmp
        except Exception as e:
            rospy.logwarn(e)
            rospy.loginfo("hand is None")
            return
        try:
            wrist_pose = self.scene.get_object_poses([objects[1]])["arm_end"]
            tmp = PoseStamped()
            tmp.pose = wrist_pose
            wrist_pose = tmp
        except Exception as e:
            rospy.loginfo("wrist is None")
            return
        hand_distance = self.calc_distance(end_pose, hand_pose)
        arm_distance, t = self.calc_arm_distance(hand_pose, wrist_pose)
        """ if hand_distance < border or arm_distance < border:
            self.cob_group.set_random_target()
            self.cob_group.plan()
            self.cob_group.go(wait=True)
            rospy.loginfo("hand is too close") """
        if hand_distance < border:
            rospy.loginfo("hand is too close")
            target = PoseStamped()
            target.pose.position.x = (
                end_pose.pose.position.x
                + (end_pose.pose.position.x - hand_pose.pose.position.x) * 0.05
            )
            target.pose.position.y = (
                end_pose.pose.position.y
                + (end_pose.pose.position.y - hand_pose.pose.position.y) * 0.05
            )
            target.pose.position.z = (
                end_pose.pose.position.z
                + (end_pose.pose.position.z - hand_pose.pose.position.z) * 0.05
            )
            if not self.is_cob_active:
                self.cob_move_to(target)
        elif arm_distance < border:
            rospy.loginfo("arm is too close")
            target = PoseStamped()
            target.pose.position.x = (
                end_pose.pose.position.x
                + (end_pose.pose.position.x - wrist_pose.pose.position.x) * 0.05
            )
            target.pose.position.y = (
                end_pose.pose.position.y
                + (end_pose.pose.position.y - wrist_pose.pose.position.y) * 0.05
            )
            target.pose.position.z = (
                end_pose.pose.position.z
                + (end_pose.pose.position.z - wrist_pose.pose.position.z) * 0.05
            )
            if not self.is_cob_active:
                self.cob_move_to(target)
        rospy.loginfo((hand_distance, arm_distance))
        rospy.Publisher("/signal", String, queue_size=1).publish("cob_avoid")
        # 腕とエンドエフェクタの距離を計算

    def calc_arm_distance(self, p1, p2):
        end_pose = self.cob_group.get_current_pose()

        left = 0
        right = 1
        while right - left > 0.001:
            mid1 = left + (right - left) / 3
            mid2 = right - (right - left) / 3
            pmid1 = self.calc_inter_point(p1, p2, mid1)
            pmid2 = self.calc_inter_point(p1, p2, mid2)
            if self.calc_distance(pmid1, end_pose) < self.calc_distance(
                pmid2, end_pose
            ):
                right = mid2
            else:
                left = mid1
        return (
            self.calc_distance(
                self.calc_inter_point(p1, p2, (left + right) / 2), end_pose
            ),
            left + right / 2,
        )

    def calc_distance(self, p1: PoseStamped, p2: PoseStamped) -> float:
        return math.sqrt(
            (p1.pose.position.x - p2.pose.position.x) ** 2
            + (p1.pose.position.y - p2.pose.position.y) ** 2
            + (p1.pose.position.z - p2.pose.position.z) ** 2
        )

    def calc_inter_point(self, p1, p2, t):
        p1x, p1y, p1z = p1.pose.position.x, p1.pose.position.y, p1.pose.position.z
        p2x, p2y, p2z = p2.pose.position.x, p2.pose.position.y, p2.pose.position.z
        x = p1x + (p2x - p1x) * t
        y = p1y + (p2y - p1y) * t
        z = p1z + (p2z - p1z) * t
        new_pose = PoseStamped()
        new_pose.pose.position.x = x
        new_pose.pose.position.y = y
        new_pose.pose.position.z = z
        return new_pose


def main():
    rospy.init_node("operater")
    op = Operater()
    rospy.loginfo("hand is None")
    rospy.spin()


if __name__ == "__main__":
    main()
