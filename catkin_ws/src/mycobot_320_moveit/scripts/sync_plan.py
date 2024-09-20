#!/usr/bin/env python3
import time
import math
import rospy
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint

from pymycobot.mycobot import MyCobot


mc:MyCobot = None


def callback(data:JointTrajectory):
    # rospy.loginfo(rospy.get_caller_id() + "%s", data.position)
    radians = data.points[0].positions
    mc.send_radians(radians, 20)
def listener():
    global mc
    rospy.init_node("mycobot_reciver", anonymous=True)

    port = rospy.get_param("~port", "/dev/ttyUSB0")
    baud = rospy.get_param("~baud", 115200)
    print(port, baud)
    mc = MyCobot(port, baud)
    time.sleep(0.05)
    mc.set_free_mode(1)
    time.sleep(0.05)

    rospy.Subscriber("/arm_controller/command", JointTrajectory, callback)
    rospy.spin()


if __name__ == "__main__":
    listener()
