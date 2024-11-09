#!/usr/bin/env python3
import sys
sys.path.append("../")
import rospy
import moveit_commander

from typing import overload

from cobotta_arm import CobottaArmBcapInterface
from cobotta_ros import CobottaArmMoveit
from cobotta_k3hand import K3HandinCobotta

def state_check(bcobotta:CobottaArmBcapInterface):
    assert bcobotta.hControllerVt != -1
    assert bcobotta.hControllerValue != ""
    assert bcobotta.k3Hand.handleVt != -1
    assert bcobotta.k3Hand.handleValue != ""

def pipetthing(bcobotta:CobottaArmBcapInterface, rcobotta:CobottaArmMoveit):
    state_check(bcobotta)
    
    # 1. ピペットを横から把持しにいく
    bcobotta.k3Hand.movej(2)
    rospy.sleep(0.5)
    bcobotta.k3Hand.movej(3)
    rospy.sleep(0.5)
    
    # 2. ピペッティングのための姿勢に移動
    bcobotta.k3Hand.movej(4)
    rospy.sleep(0.5)
    bcobotta.k3Hand.movej(8)
    rospy.sleep(0.5)
    bcobotta.k3Hand.movej(7)
    rospy.sleep(0.5)
    bcobotta.k3Hand.movej(6)
    
if __name__ == "__main__":
    rospy.init_node("pipetthing")
    moveit_commander.roscpp_initialize(sys.argv)
    
    bcobotta = CobottaArmBcapInterface()
    rcobotta = CobottaArmMoveit()
    
    rospy.spin()