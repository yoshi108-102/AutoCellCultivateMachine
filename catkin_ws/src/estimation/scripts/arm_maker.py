#!/usr/bin/env python3
import math
import sys

import moveit_commander
import rospy
import tf
from geometry_msgs.msg import PoseArray, PoseStamped, Quaternion


def arm_maker(data:PoseArray,scene:moveit_commander.PlanningSceneInterface):
    target = ["RWrist", "RElbow", "RShoulder", "LWrist", "LElbow", "LShoulder"]
    pre_arm = scene.get_known_object_names()
    rospy.loginfo(pre_arm)
    if pre_arm:
        for object in pre_arm:
            scene.remove_world_object(object)
    radius = 0.03
    for i in range(1,len(data.poses)):
        if i == 3:
            continue
        pre = data.poses[i-1]
        cur = data.poses[i]
        if pre.orientation == Quaternion(0,0,0,0) or cur.orientation == Quaternion(0,0,0,0):
            continue
        add_cylinder_between_points(scene,[pre.position.x,pre.position.y,pre.position.z],[cur.position.x,cur.position.y,cur.position.z],radius,i)
    rospy.loginfo(scene.get_known_object_names())

import math

from geometry_msgs.msg import Pose
from moveit_commander import PlanningSceneInterface
from shape_msgs.msg import SolidPrimitive
from tf.transformations import quaternion_from_matrix


def add_cylinder_between_points(planning_scene_interface, point1, point2, radius,i:int):
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
    length = math.sqrt((x2 - x1)**2 + (y2 - y1)**2 + (z2 - z1)**2)

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
        z_axis[0] * axis_y - z_axis[1] * axis_x
    ]

    # 回転行列を四元数に変換
    rotation_angle = math.acos(dot_product)
    if math.isclose(rotation_angle, 0):
        quaternion = [0, 0, 0, 1]  # 回転なし
    else:
        quaternion = quaternion_from_matrix([
            [0, -cross_product[2], cross_product[1], axis_x],
            [cross_product[2], 0, -cross_product[0], axis_y],
            [-cross_product[1], cross_product[0], 0, axis_z],
            [0, 0, 0, 1]
        ])

    # 円柱オブジェクトの定義
    cylinder = SolidPrimitive()
    cylinder.type = SolidPrimitive.CYLINDER
    cylinder.dimensions = [length, radius]

    # 円柱のポーズ
    pose = Pose()
    pose.position.x = center_x
    pose.position.y = center_y
    pose.position.z = center_z
    pose.orientation.x = quaternion[0]
    pose.orientation.y = quaternion[1]
    pose.orientation.z = quaternion[2]
    pose.orientation.w = quaternion[3]
    pose_stamped = PoseStamped()
    pose_stamped.header.frame_id = "mycobot_base_link"
    pose_stamped.header.stamp = rospy.Time.now()
    pose_stamped.pose = pose
    

    # シーンに円柱を追加
    collision_object_id = "cylinder_between_points" + str(i)
    planning_scene_interface.add_cylinder(collision_object_id, pose_stamped, height=length, radius=radius)

def main():
    rospy.init_node("arm_maker", anonymous=True)
    moveit_commander.roscpp_initialize(sys.argv)
    scene = moveit_commander.PlanningSceneInterface()
    rospy.Subscriber("arm_pose", PoseArray, arm_maker, scene)
    rospy.spin()
if __name__ == "__main__":
    main()