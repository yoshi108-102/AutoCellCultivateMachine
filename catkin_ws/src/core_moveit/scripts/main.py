#!/usr/bin/env python3
import sys
from functools import partial

import moveit_commander
import rospy
from cobotta.cobotta_arm import CobottaArmBcapInterface as Arm
from geometry_msgs.msg import PoseStamped
from mycobot.mycobot_k3hand import K3HandinMyCobot as McK3hand
from operater import Operater
from task.catch_pipettte import catch_pipette
from task.change_mode import changeMode
from task.drip_to_dish import drip_to_dish
from task.get_medium import get_medium
from task.open_dish import open_dish
from task.pipetthing import pipetthing


def avoid_hand_collision(_,op:Operater):
    cb_hand_dist, cb_arm_dist,border = op.cob_distances()
    if cb_hand_dist < border or cb_arm_dist < border:
        changeMode(514)
        op.cob_avoid()
    
def main():
    rospy.init_node("main_move")
    moveit_commander.roscpp_initialize(sys.argv)
    op = Operater()
    arm = Arm()
    #rospy.Timer(rospy.Duration(0.1), partial(avoid_hand_collision,op))
    mck3hand = McK3hand()
    changeMode(0)
    arm.controller_connect()
    arm.add_k3hand()
    changeMode(514)
    catch_pipette(op, arm)
    get_medium(op,arm)
    while True:
            is_succeed = op.cob_avoid(None)
            rospy.loginfo(f"is_succeed:{is_succeed}")
            if is_succeed:
                break
    open_dish(op, mck3hand)
    drip_to_dish(op,arm)

if __name__ == "__main__":
    main()
