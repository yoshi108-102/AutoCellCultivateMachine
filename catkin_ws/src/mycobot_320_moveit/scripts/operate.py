#!/usr/bin/env python3
import math
import time

import moveit_commander
import rospy
import tf2_geometry_msgs
import tf2_ros
from geometry_msgs.msg import PoseArray, PoseStamped
from pymycobot.mycobot import MyCobot
from sensor_msgs.msg import JointState, PointCloud2
from tf_listener import TfListener
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
from visualization_msgs.msg import MarkerArray


class MycobotOperator:
    def __init__(self, port, baud):
        self.mc = None
        self.robot_arm_pub = rospy.Publisher(
            "/arm_controller/command", JointTrajectory, queue_size=10
        )
        self.scene = moveit_commander.PlanningSceneInterface()
        self.marker_pub = rospy.Publisher(
            "visualization_marker", MarkerArray, queue_size=10
        )
        self.pipette_sub = rospy.Subscriber(
            "target_estimation", PoseStamped, self.end_effector_pose
        )
        self.joint_state = JointState(
            header=rospy.Header(),
            name=[
                "mycobot_arm_joint_0",
                "mycobot_arm_joint_1",
                "mycobot_arm_joint_2",
                "mycobot_arm_joint_3",
                "mycobot_arm_joint_4",
                "mycobot_arm_joint_5",
            ],
            position=[0, 0, 0, 0, 0, 0],
        )
        self.joint_state_pub = rospy.Publisher(
            "mycobot/joint_states", JointState, queue_size=10
        )
        self.move_group = moveit_commander.MoveGroupCommander("arm_group")
        self.move_group.set_planning_time(0.03)
        self.listener = TfListener()
        self.camera_world_name = "camera_link"
        # self.arm_sub = rospy.Subscriber("arm_estimation",PoseArray,self.armdata_cb)
        self.mycobot_init(port, baud)

    def mycobot_init(self, port, baud):
        try:
            self.mc = MyCobot(port, baud)
            time.sleep(0.05)
            self.mc.set_free_mode(1)
            time.sleep(0.05)
            self.mc.send_radians([0, 0, 0, 0, 0, 0], speed=50)
        except Exception as e:
            rospy.logwarn(e)

    def end_effector_pose(self, posestamped: PoseStamped, deg=0):
        transed = self.listener.do_transform_pose(
            posestamped, "camera_link", "base_link"
        )
        (x, y, z) = (
            transed.pose.position.x,
            transed.pose.position.y,
            transed.pose.position.z,
        )
        try:
            self.move_group.set_pose_target([x, y, z, -math.pi, 0, 0])
            p = self.move_group.plan()
            tar_jo = list(p[1].joint_trajectory.points[-1].positions)
            tar_jo[5] = math.pi * deg / 180
            self.joint_state.position = tar_jo
            self.mc_send_radians(tar_jo, 70)
            # rospy.sleep(0.1)
        except Exception as e:
            rospy.loginfo("Failed to move end effector")

    def mc_send_radians(self, radians, speed=100):
        trajectory_msg = JointTrajectory()
        trajectory_msg.joint_names = [
            "mycobot_arm_joint_0",
            "mycobot_arm_joint_1",
            "mycobot_arm_joint_2",
            "mycobot_arm_joint_3",
            "mycobot_arm_joint_4",
            "mycobot_arm_joint_5",
        ]
        point_msg = JointTrajectoryPoint()

        point_msg.positions = radians

        point_msg.time_from_start = rospy.Duration(1.0 * 100 / speed)
        trajectory_msg.points.append(point_msg)

        rospy.loginfo("Publishing JointTrajectory message...")
        self.robot_arm_pub.publish(trajectory_msg)
        if self.mc is not None:
            self.mc.send_radians(radians, speed=speed)
        rospy.loginfo("Done.")


def main():
    rospy.init_node("joint_controller")
    mcOperator = MycobotOperator("/dev/ttyUSB0", 115200)
    rospy.loginfo(mcOperator.scene.get_known_object_names())
    while not rospy.is_shutdown():
        mcOperator.joint_state_pub.publish(mcOperator.joint_state)
        mcOperator.joint_state.header.stamp = rospy.Time.now()


if __name__ == "__main__":
    main()
