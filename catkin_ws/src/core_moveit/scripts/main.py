#!/usr/bin/env python3
import sys

import moveit_commander
import rospy
from cobotta.cobotta_arm import CobottaArmBcapInterface as Arm
from geometry_msgs.msg import PoseStamped
from operater import Operater
from task.catch_pipettte import catch_pipette
from task.change_mode import changeMode
from task.pipetthing import pipetthing

rospy.init_node('main_move')
moveit_commander.roscpp_initialize(sys.argv)

op = Operater()
arm = Arm()

changeMode(0)
arm.controller_connect()
arm.add_k3hand()
changeMode(514)
pos = rospy.wait_for_message('object_pose',PoseStamped)
catch_pipette(pos,op,arm)
pipetthing(arm,5)
rospy.spin()