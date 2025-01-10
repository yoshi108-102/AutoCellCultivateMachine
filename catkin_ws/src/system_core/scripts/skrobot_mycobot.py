import control_msgs.msg
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
            controller_type="arm_controller",
            controller_action="arm_controller/follow_joint_trajectory",
            controller_state="arm_controller/state",
            action_type=control_msgs.msg.FollowJointTrajectoryAction,
            joint_names=[
                "arm_joint_0",
                "arm_joint_1",
                "arm_joint_2",
                "arm_joint_3",
                "arm_joint_4",
                "arm_joint_5",
            ],
        )

    def default_controller(self):
        return [self.rarm_controller]


def main():
    rospy.init_node("manipulate_two_robot")
    namespace = "robot_a"
    robot_a_model = RobotModel()
    robot_a_model.load_urdf_from_robot_description(namespace + "/robot_description")
    robot_a_ri = MyCobotROSRobotInterface(robot_a_model, namespace="robot_a")

    namespace = "robot_b"
    robot_b_model = RobotModel()
    robot_b_model.load_urdf_from_robot_description(namespace + "/robot_description")
    robot_b_ri = MyCobotROSRobotInterface(robot_b_model, namespace="robot_b")
    viewer = TrimeshSceneViewer()
    viewer.add(robot_a_model)
    robot_b_model.translate((1.0, 0, 0.0))
    viewer.add(robot_b_model)
    viewer.show()

    print(robot_a_model.joint_list)
    robot_a_model.arm_joint_1.joint_angle(-0.5)
    robot_a_ri.angle_vector(
        robot_a_model.angle_vector(), 3
    )  # robot_aの実機(gazeboも)に指令を送る
    robot_a_ri.wait_interpolation()  # 補間が終わるまで待つ。

    robot_b_model.arm_joint_1.joint_angle(0.15)
    robot_b_ri.angle_vector(
        robot_b_model.angle_vector(), 3
    )  # robot_bの実機(gazeboも)に指令を送る
    robot_b_ri.wait_interpolation()  # 補間が終わるまで待つ。
    rospy.sleep(7)


if __name__ == "__main__":
    main()
