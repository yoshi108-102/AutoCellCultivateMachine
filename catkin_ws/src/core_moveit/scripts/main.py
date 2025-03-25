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
from task.get_medium import get_medium, move_to_pose
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

def open_house():
    rospy.init_node("main_move")
    moveit_commander.roscpp_initialize(sys.argv)
    op = Operater()
    arm = Arm()
    #rospy.Timer(rospy.Duration(0.1), partial(avoid_hand_collision,op))
    changeMode(0)
    arm.controller_connect()
    arm.add_k3hand()
    rospy.sleep(1)
    changeMode(514)
    pipette_move_list = {
        "lup" : [-0.628,-0.76,1.465,1.54,0.71,-2.84],
        "ldown" : [-0.628,0.74,0.803,1.54,0.71,-2.84],
        "rup" : [-0.23,-0.76,1.465,1.54,0.71,-2.84],
        "rdown" : [-0.23,0.74,0.803,1.54,0.71,-2.84],
    }
    cnt = 0
    loop = ["lup","ldown","rup","rdown"]
    while True:
        move_to_pose(pipette_move_list[loop[cnt % len(pipette_move_list.keys())]],op,arm)
        rospy.sleep(1)
        if "down" in loop[cnt % len(pipette_move_list.keys())]:
            pipetthing(arm,4)
        rospy.sleep(1)
        cnt += 1
def grasp_pipette():
    rospy.init_node("main_move")
    moveit_commander.roscpp_initialize(sys.argv)
    op = Operater()
    arm = Arm()
    #rospy.Timer(rospy.Duration(0.1), partial(avoid_hand_collision,op))
    changeMode(0)
    arm.controller_connect()
    arm.add_k3hand()
    while True:
        changeMode(0)
        rospy.logwarn("cobottaの手が3秒後に開きます。もしピペットがcobottaの手の中にあるなら、掴んで落ちないようにしてください。")
        rospy.sleep(3)
        arm.k3Hand.movej(0)
        rospy.loginfo("cobottaの手の中にピペットを入れてください。3秒後に手を閉じます。")
        rospy.sleep(3)
        arm.k3Hand.movej(1)
        arm.k3Hand.movej(2)
        arm.k3Hand.movej(3)
        rospy.loginfo("正しく把持できているかのテストを行います。")
        pipetthing(arm,3)
        result = input("ピペッティングは正しく行われていましたか？(y/n)")
        if result == 'y':
            break
        else:
            rospy.loginfo("もういちど把持をやりなおします。")
        
if __name__ == "__main__":
    choice = ''
    while True:
        choice = input("cobottaにピペットを把持させる(c)/デモを始める(s)")
        if choice == 'c' or choice == 's':
            break
    if choice == 's':
        open_house()
    else:
        grasp_pipette()
