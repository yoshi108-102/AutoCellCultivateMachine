#!/usr/bin/env python3
import sys

import control_msgs.msg
import moveit_commander
import rospy
from skrobot.interfaces.ros.base import ROSRobotInterfaceBase
from skrobot.model import RobotModel
from skrobot.viewers import TrimeshSceneViewer


class MyCobotROSRobotInterface(ROSRobotInterfaceBase):

    def __init__(self, *args, **kwargs):
        super(MyCobotROSRobotInterface, self).__init__(*args, **kwargs)

    @property
    def rarm_controller(self):
        return dict(
            controller_type="mycobot_arm_controller",
            controller_action="mycobot_arm_controller/follow_joint_trajectory",
            controller_state="mycobot_arm_controller/state",
            action_type=control_msgs.msg.FollowJointTrajectoryAction,
            joint_names=[
                "mycobot_arm_joint_0",
                "mycobot_arm_joint_1",
                "mycobot_arm_joint_2",
                "mycobot_arm_joint_3",
                "mycobot_arm_joint_4",
                "mycobot_arm_joint_5",
            ],
        )

    def default_controller(self):
        return [
            self.rarm_controller,
        ]


rospy.init_node("manipulate_two_robot")
moveit_commander.roscpp_initialize(sys.argv)
move_group = moveit_commander.MoveGroupCommander("arm_group")
move_group = moveit_commander.MoveGroupCommander("arm")
robot_model = RobotModel()
robot_model.load_urdf_from_robot_description("/robot_description")
ri = MyCobotROSRobotInterface(robot_model)
viewer = TrimeshSceneViewer()
viewer.add(robot_model)
viewer.show()

robot_model.angle_vector(ri.angle_vector())
robot_model.mycobot_arm_joint_0.joint_angle(0)
robot_model.mycobot_arm_joint_5.joint_angle(-1.7)
ri.angle_vector(robot_model.angle_vector(), 3)  # robot_aの実機(gazeboも)に指令を送る
ri.wait_interpolation()
