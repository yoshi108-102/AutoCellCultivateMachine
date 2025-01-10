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
            controller_type="arm_a_controller",
            controller_action="arm_a_controller/follow_joint_trajectory",
            controller_state="arm_a_controller/state",
            action_type=control_msgs.msg.FollowJointTrajectoryAction,
            joint_names=[
                "arm_a_arm_joint_0",
                "arm_a_arm_joint_1",
                "arm_a_arm_joint_2",
                "arm_a_arm_joint_3",
                "arm_a_arm_joint_4",
                "arm_a_arm_joint_5",
            ],
        )

    @property
    def larm_controller(self):
        return dict(
            controller_type="arm_b_controller",
            controller_action="arm_b_controller/follow_joint_trajectory",
            controller_state="arm_b_controller/state",
            action_type=control_msgs.msg.FollowJointTrajectoryAction,
            joint_names=[
                "arm_b_arm_joint_0",
                "arm_b_arm_joint_1",
                "arm_b_arm_joint_2",
                "arm_b_arm_joint_3",
                "arm_b_arm_joint_4",
                "arm_b_arm_joint_5",
            ],
        )

    def default_controller(self):
        return [self.rarm_controller, self.larm_controller]


rospy.init_node("manipulate_two_robot")
robot_model = RobotModel()
robot_model.load_urdf_from_robot_description("/robot_description")
ri = MyCobotROSRobotInterface(robot_model)


viewer = TrimeshSceneViewer()
viewer.add(robot_model)
viewer.add(robot_model)
viewer.show()

robot_model.arm_a_arm_joint_1.joint_angle(0.5)
ri.angle_vector(robot_model.angle_vector(), 3)  # robot_aの実機(gazeboも)に指令を送る
ri.wait_interpolation()  # 補間が終わるまで待つ。
