#!/usr/bin/env python3
import moveit_commander
import rospy
import geometry_msgs.msg
import sys
import tf.transformations
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
import tf
import math
from pymycobot.mycobot import MyCobot
import time
from geometry_msgs.msg import PoseStamped,PoseArray,Pose
from functools import partial
from visualization_msgs.msg import MarkerArray,Marker
class My1cobotOperator:
    def __init__(self, port, baud):
        self.mc = None
        self.robot_arm_pub = rospy.Publisher('/arm_controller/command', JointTrajectory, queue_size=10)
        self.scene = moveit_commander.PlanningSceneInterface()
        self.marker_pub = rospy.Publisher("visualization_marker", MarkerArray, queue_size=10)
        rospy.sleep(2)
        self.move_group = moveit_commander.MoveGroupCommander("arm_group")
        self.move_group.set_planning_time(0.03)
        self.listener = tf.TransformListener()
        self.camera_world_name = "camera_link"
        self.arm_sub = rospy.Subscriber("arm_estimation",PoseArray,self.armdata_cb)
        self.mycobot_init(port, baud)
    def mycobot_init(self,port,baud):
        try:
            self.mc = MyCobot(port, baud)
            time.sleep(0.05)
            self.mc.set_free_mode(1)
            time.sleep(0.05)
            self.mc.send_radians([0, 0, 0, 0, 0, 0], speed=50)
        except Exception as e:
            rospy.logwarn(e)
    def end_effector_pose(self,x, y, z,deg):
        try:
            self.move_group.set_pose_target([x, y, z, -math.pi, 0, 0])
            p = self.move_group.plan()
            tar_jo = list(p[1].joint_trajectory.points[-1].positions)
            tar_jo[5] = math.pi * deg/ 180
            self.mc_send_radians(tar_jo, 70)
            #rospy.sleep(0.1)
        except Exception as e:
            rospy.loginfo("Failed to move end effector")
    def mc_send_radians(self,radians, speed=100):
        trajectory_msg = JointTrajectory()
        trajectory_msg.joint_names = ["arm_joint_0", "arm_joint_1", "arm_joint_2", "arm_joint_3", "arm_joint_4", "arm_joint_5"]
        point_msg = JointTrajectoryPoint()

        point_msg.positions = radians

        point_msg.time_from_start = rospy.Duration(1.0*100 / speed)
        trajectory_msg.points.append(point_msg)

        rospy.loginfo("Publishing JointTrajectory message...")
        self.robot_arm_pub.publish(trajectory_msg)
        if self.mc is not None:
            self.mc.send_radians(radians, speed=speed)
        rospy.loginfo("Done.")

    """ def armdata_cb(self,data:PoseArray):
        #poseデータを受け取って円柱を描画
        transformed_poses = []
        for i in range(1,len(data.poses)):
            pose = PoseStamped()
            pose.header.frame_id = self.camera_world_name
            pose.header.stamp = rospy.Time.now()
            pose.pose = data.poses[i]
            pos = self.listener.transformPose(self.camera_world_name,pose)
            transformed_poses.append(pos)
        print("transformed_poses",transformed_poses)
        for i in range(1,len(transformed_poses)):
            x1,y1,z1 = transformed_poses[i-1].pose.position.x,transformed_poses[i-1].pose.position.y,transformed_poses[i-1].pose.position.z
            x2,y2,z2 = transformed_poses[i].pose.position.x,transformed_poses[i].pose.position.y,transformed_poses[i].pose.position.z
            direction = [x2-x1,y2-y1,z2-z1]
            length = math.sqrt(direction[0]**2 + direction[1]**2 + direction[2]**2)
            if abs(length) < 0.01:
                continue
            direction = [x/length for x in direction]
            roll,pitch,yaw = 0,math.atan2(direction[1],direction[0]),math.asin(direction[2])
            q = tf.transformations.quaternion_from_euler(roll,pitch,yaw)
            pose = Pose()
            pose.position.x = (x1+x2)/2
            pose.position.y = (y1+y2)/2
            pose.position.z = (z1+z2)/2
            pose.orientation.x = q[0]
            pose.orientation.y = q[1]
            pose.orientation.z = q[2]
            pose.orientation.w = 1.0
            posestamped = PoseStamped()
            posestamped.pose = pose
            posestamped.header.frame_id = self.camera_world_name
            posestamped.header.stamp = rospy.Time.now()
            self.scene.add_cylinder("cylinder"+str(i),posestamped,length,0.01)
        return """
    def armdata_cb(self,data:PoseArray):
        #poseデータを受け取ってmarkerを描画
        mkarray = MarkerArray()
        for i in range(1,len(data.poses)):
            marker = Marker()
            marker.header.frame_id = self.camera_world_name
            marker.header.stamp = rospy.Time.now()
            marker.type = Marker.CYLINDER
            marker.action = Marker.ADD
            marker.scale.x = 0.01
            marker.scale.y = 0.01
            marker.scale.z = 0.1
            marker.color.a = 1.0
            marker.color.r = 1.0
            marker.color.g = 0.0
            marker.color.b = 0.0
            pose = PoseStamped()
            pose.header.frame_id = self.camera_world_name
            pose.header.stamp = rospy.Time.now()
            pose.pose = data.poses[i-1]
            pos = self.listener.transformPose(self.camera_world_name,pose)
            marker.pose = pos.pose
            mkarray.markers.append(marker)
        self.marker_pub.publish(mkarray)     
def main():
    rospy.init_node('joint_controller')

    mcOperator = My1cobotOperator("/dev/ttyUSB0", 115200)
    while not rospy.is_shutdown():
        try:
            mcOperator.listener.waitForTransform("base_link","Head",rospy.Time(0),rospy.Duration(0.03))
            mcOperator.listener.waitForTransform("base_link","camera_link",rospy.Time(0),rospy.Duration(0.03))
            pos = mcOperator.listener.lookupTransform("base_link","Head",rospy.Time(0))
        except Exception as e:
            rospy.logwarn(e)
            continue
        mcOperator.end_effector_pose(pos[0][0]-0.02,pos[0][1],pos[0][2]+0.02,0)
        print("object list",mcOperator.scene.get_objects())

if __name__ == '__main__':
    main()