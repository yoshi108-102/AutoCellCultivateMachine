#!/usr/bin/env python3
import math
import sys

import rospy
import moveit_commander

from trajectory_msgs.msg import JointTrajectory
from geometry_msgs.msg import PoseStamped
from std_msgs.msg import Int32,String
from tf_listener import TfListener

from constants import MODE

from visualization_msgs.msg import Marker
def make_marker(pose:PoseStamped,frame_id:str) -> Marker:
    marker = Marker()
    marker.id = 1
    marker.header.frame_id = frame_id
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
    return marker
class CobottaArmMoveit:
    def __init__(self,group_name:str="arm"):
        self.move_group = moveit_commander.MoveGroupCommander(group_name)
        self.robot_commander = moveit_commander.RobotCommander()
        self.move_group.set_goal_position_tolerance(0.03)
        self.move_group.set_planning_time(0.05)
        
        self.taskPub = rospy.Publisher("/cobotta/task",String,queue_size=10)
        
        self.changeModePub = rospy.Publisher(
            "/cobotta/ChangeMode", Int32, queue_size=10
        )
        self.modeSub = rospy.Subscriber(
            "/cobotta/CurMode", Int32, self.modeCallback
        )

        self.armPub = rospy.Publisher(
            "/cobotta/arm_controller/command", JointTrajectory, queue_size=10
        )
        self.pointSub = rospy.Subscriber(
            "target_estimation", PoseStamped, self.pipettePointCallback
        )
        self.pipettePointSub = rospy.Subscriber(
            "/target_estimation", PoseStamped, self.pipettePointCallback
        )
        self.dishPointSub = rospy.Subscriber(
            "/dish/target_estimation", PoseStamped, self.dishPointCallback
        )
        self.tubePointSub = rospy.Subscriber(
            "/tube/target_estimation", PoseStamped, self.tubePointCallback
        )
        self.task = "pipetting"
        self.tfListener = TfListener()
        self.state = True
        self.mode = MODE.SLAVE
    
    def usage(self):
        rospy.logerr(
            """
            Usage: roslaunch denso_robot_bringup cobotta_bringup.launch sim:=false \
                   roslaunch bcap_service bcap_service.launch \
                   rosrun cobotta_moveit cobotta_moveit.py
            """
        )
    
    def changeMode(self, mode: int):
        # 0: normal mode, 514: slave mode
        #　なぜかうまくいかないが、あとで/cobotta/CurModeのトピックをSubScribeして変更が反映されたか確認するようにしたい
        if self.mode == mode:
            rospy.loginfo(f"Already in {mode} mode")
            return
        if mode == MODE.NORMAL:
            self.state = False
        elif mode == MODE.SLAVE:
            self.state = True
        rospy.loginfo(mode)
        while self.mode != mode:
            self.changeModePub.publish(Int32(data=mode))
            rospy.sleep(0.1)
    
    def modeCallback(self, msg: Int32):
        self.mode = msg.data
        rospy.loginfo(f"Mode changed to {self.mode}")
    
    def pipettePointCallback(self,msg:PoseStamped):
        if not self.state:
            return
        if (rospy.Time.now() - msg.header.stamp) > rospy.Duration(0.05):
            return
        msg.pose.position.z += 0.04
        endEffectorPose = self.tfListener.lookupTransform("base_link","J6").transform.translation
        (ex,ey,ez) = (endEffectorPose.x,endEffectorPose.y,endEffectorPose.z)
        pose = self.tfListener.do_transform_pose(msg,"camera_link","base_link")
        dist = math.sqrt((ex - pose.pose.position.x)**2 + (ey - pose.pose.position.y)**2 + (ez - pose.pose.position.z)**2)
        if dist < 0.1:
            #rospy.loginfo("End effector is already at the target")
            now_state = self.move_group.get_current_joint_values()
            now_state[3] = -1.6
            now_state[4] = 1.8
            self.move_group.go(now_state,wait=True)
            self.taskPub.publish(String("catch_pipette"))
            return
        pub = rospy.Publisher("visualization_marker", Marker, queue_size=20)
        pub.publish(make_marker(pose,"base_link"))
        try:
            self.move_group.set_pose_target(pose.pose)
            trajectory = self.move_group.plan()
            target_joint = trajectory[1].joint_trajectory.points[-1].positions
            rospy.loginfo(target_joint)
            self.move_group.go(target_joint,wait=True)
        except Exception as e:
            rospy.logerr(e)
            rospy.loginfo("Failed to move end effector")
    def dishPointCallback():
        pass
    def tubePointCallback():
        pass
if __name__ == "__main__":
    rospy.init_node("cobotta_arm")
    moveit_commander.roscpp_initialize(sys.argv)
    cobotta = CobottaArmMoveit()
    rospy.spin()
