#!/usr/bin/env python3
import math

import rospy
import moveit_commander

from trajectory_msgs.msg import JointTrajectory,JointTrajectoryPoint
from geometry_msgs.msg import PoseStamped
from std_msgs.msg import Int32
from tf_listener import TfListener

class CobottaArmMoveit:
    def __init__(self,group_name:str="arm"):
        self.move_group = moveit_commander.MoveGroupCommander(group_name)
        self.move_group.set_planning_time(0.03)
        
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
        transform_stamped = self.tfListener.lookupTransform(
            "base_link", msg.header.frame_id
        )
        x, y, z = (
            transform_stamped.transform.translation.x,
            transform_stamped.transform.translation.y,
            transform_stamped.transform.translation.z,
        )
        try:
            self.move_group.set_pose_target([x, y, z, -math.pi, 0, 0])
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
