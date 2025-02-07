#!/usr/bin/env python3
import math
import sys
from functools import partial

import moveit_commander
import rospy
import tf
from geometry_msgs.msg import Pose, PoseArray, PoseStamped, Quaternion
from moveit_msgs.msg import ObjectColor
from shape_msgs.msg import SolidPrimitive
from std_msgs.msg import ColorRGBA
from tf.transformations import quaternion_from_matrix


def arm_maker(data: PoseArray, scene: moveit_commander.PlanningSceneInterface):
    pre_arm = scene.get_known_object_names()
    if "collision" in pre_arm:
        pre_arm.remove("collision")
    rospy.loginfo(pre_arm)
    if pre_arm:
        for object in pre_arm:
            scene.remove_world_object(object)
    center = PoseStamped()
    center.header.frame_id = "mycobot_base_link"
    center.header.stamp = rospy.Time.now()
    for i in range(0, len(data.poses)):
        center.pose.position.x += data.poses[i].position.x
        center.pose.position.y += data.poses[i].position.y
        center.pose.position.z += data.poses[i].position.z
    center.pose.position.x /= len(data.poses)
    center.pose.position.y /= len(data.poses)
    center.pose.position.z /= len(data.poses)
    center.pose.orientation.w = 1.0
    wrist = PoseStamped()
    wrist.header.frame_id = "mycobot_base_link"
    wrist.header.stamp = rospy.Time.now()
    wrist.pose = data.poses[0]
    hand_radius = math.sqrt((center.pose.position.x - wrist.pose.position.x)**2 + (center.pose.position.y - wrist.pose.position.y)**2)
    hand_radius = hand_radius * 2.0 / 3.0
    arm_radius = hand_radius
    add_sphere(scene, center, radius=hand_radius, name="hand")
    add_sphere(scene, wrist, radius=hand_radius / 5, name="wrist")
    arm_end = PoseStamped()
    size = 4.0
    arm_end.header = center.header
    arm_end.pose.position.x = (
        center.pose.position.x + (wrist.pose.position.x - center.pose.position.x) * size
    )
    arm_end.pose.position.y = (
        center.pose.position.y + (wrist.pose.position.y - center.pose.position.y) * size
    )
    arm_end.pose.position.z = (
        center.pose.position.z + (wrist.pose.position.z - center.pose.position.z) * size
    )
    arm_end.pose.orientation.w = 1.0
    add_sphere(scene, arm_end, radius=hand_radius/5, name="arm_end")
    cur = arm_end.pose
    add_cylinder_between_points(
        scene,
        [wrist.pose.position.x, wrist.pose.position.y, wrist.pose.position.z],
        [cur.position.x, cur.position.y, cur.position.z],
        arm_radius,
        i,
    )
    rospy.loginfo(scene.get_known_object_names())


def add_sphere(
    scene: moveit_commander.PlanningSceneInterface,
    pose: PoseStamped,
    radius: float,
    name,
):
    scene.add_sphere(name, pose, radius)


def add_cylinder_between_points(
    planning_scene_interface, point1, point2, radius, i: int
):
    """
    2点間を結ぶ半径rの円柱をプランニングシーンに追加する関数

    :param planning_scene_interface: MoveItのPlanningSceneInterfaceオブジェクト
    :param point1: 始点の座標 [x, y, z]
    :param point2: 終点の座標 [x, y, z]
    :param radius: 円柱の半径
    """
    # 2点間のベクトル計算
    x1, y1, z1 = point1
    x2, y2, z2 = point2

    # 中心位置
    center_x = (x1 + x2) / 2
    center_y = (y1 + y2) / 2
    center_z = (z1 + z2) / 2

    # 長さ（高さ）
    length = math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2 + (z2 - z1) ** 2)
    rospy.loginfo([x / length for x in [x2 - x1, y2 - y1, z2 - z1]])
    # 軸ベクトル（正規化）
    axis_x = (x2 - x1) / length
    axis_y = (y2 - y1) / length
    axis_z = (z2 - z1) / length
    # デフォルトのz軸(0, 0, 1)を目標軸に合わせる回転行列を計算
    z_axis = [0, 0, 1]
    dot_product = axis_x * z_axis[0] + axis_y * z_axis[1] + axis_z * z_axis[2]
    cross_product = [
        z_axis[1] * axis_z - z_axis[2] * axis_y,
        z_axis[2] * axis_x - z_axis[0] * axis_z,
        z_axis[0] * axis_y - z_axis[1] * axis_x,
    ]
    quaternion = []
    # 回転行列を四元数に変換
    rotation_angle = math.acos(dot_product)
    if math.isclose(rotation_angle, 0):
        quaternion = [0, 0, 0, 1]  # 回転なし
    elif math.isclose(rotation_angle, math.pi):
        quaternion = [1, 0, 0, 0]
    else:
        cross_len = math.sqrt(sum([x * x for x in cross_product]))
        cross_product = [x / cross_len for x in cross_product]
        half_theta = rotation_angle / 2
        w = math.cos(half_theta)
        s = math.sin(half_theta)
        ux, uy, uz = cross_product[0], cross_product[1], cross_product[2]
        quaternion = [ux * s, uy * s, uz * s, w]
    # 円柱のポーズ
    pose = Pose()
    pose.position.x = center_x
    pose.position.y = center_y
    pose.position.z = center_z
    pose.orientation = Quaternion(*quaternion)
    pose_stamped = PoseStamped()
    pose_stamped.header.frame_id = "mycobot_base_link"
    pose_stamped.header.stamp = rospy.Time.now()
    pose_stamped.pose = pose

    # シーンに円柱を追加
    collision_object_id = "cylinder"
    planning_scene_interface.add_cylinder(
        collision_object_id, pose_stamped, height=length, radius=radius    )
def cb(scene,_):
    try:
        posearray = rospy.wait_for_message("hand_pose",PoseArray,timeout=0.1)
        arm_maker(posearray,scene)
    except Exception as e:
        rospy.loginfo(e)
        pre_arm = scene.get_known_object_names()
        if "collision" in pre_arm:
            pre_arm.remove("collision")
        rospy.loginfo(pre_arm)
        if pre_arm:
            for object in pre_arm:
                scene.remove_world_object(object)
        


def main():
    rospy.init_node("hand_maker", anonymous=True)
    moveit_commander.roscpp_initialize(sys.argv)
    scene = moveit_commander.PlanningSceneInterface()
    #rospy.Subscriber("hand_pose", PoseArray, arm_maker, scene)
    rospy.Timer(rospy.Duration(0.1),partial(cb,scene))
    rospy.spin()


if __name__ == "__main__":
    main()
