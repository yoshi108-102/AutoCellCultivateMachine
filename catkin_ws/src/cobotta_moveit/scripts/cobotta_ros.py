#!/usr/bin/env python3
import math
import sys

import rospy
import moveit_commander

from trajectory_msgs.msg import JointTrajectory,JointTrajectoryPoint
from geometry_msgs.msg import PoseStamped
from std_msgs.msg import Int32
from tf_listener import TfListener

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
        moveit_commander.roscpp_initialize(sys.argv)
        self.move_group = moveit_commander.MoveGroupCommander(group_name)
        self.move_group.set_goal_position_tolerance(0.1)
        self.move_group.set_planning_time(0.1)
        
        self.changeModePub = rospy.Publisher(
            "/cobotta/ChangeMode", Int32, queue_size=10
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
        self.changeModePub.publish(Int32(data=mode))
        rospy.sleep(1)
    
    def pipettePointCallback(self,msg:PoseStamped):
        if (rospy.Time.now() - msg.header.stamp) > rospy.Duration(0.05):
            return
        msg.header.frame_id = "Head"
        pose = self.tfListener.do_transform_pose(msg,"camera_link","base_link")
        rospy.loginfo(pose)
        pub = rospy.Publisher("visualization_marker", Marker, queue_size=20)
        pub.publish(make_marker(pose,"base_link"))
        try:
            self.move_group.set_pose_target(pose)
            p = self.move_group.plan()
            tar_jo = list(p[1].joint_trajectory.points[-1].positions)
            rospy.loginfo(tar_jo)
            self.move_group.go(tar_jo,wait=True)
        except Exception as e:
            rospy.logerr(e)
            rospy.loginfo("Failed to move end effector")
    def dishPointCallback():
        pass
    def tubePointCallback():
        pass
if __name__ == "__main__":
    rospy.init_node("cobotta_arm")
    cobotta = CobottaArmMoveit()
    rospy.spin()
