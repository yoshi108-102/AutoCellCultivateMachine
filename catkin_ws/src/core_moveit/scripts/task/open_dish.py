#!/usr/bin/env python3
import math
import os
import sys

import moveit_commander
import tf
import tf.transformations
from geometry_msgs.msg import PoseStamped

sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
import rospy
from cobotta.cobotta_arm import CobottaArmBcapInterface as Arm
from cobotta.constants import MODE
from geometry_msgs.msg import Quaternion
from operater import Operater
from std_msgs.msg import Int32

from .change_mode import changeMode

DISH_OFFSET = 0.1
def open_dish(pos:PoseStamped,op:Operater,arm:Arm):
    #ディッシュのちょっと上まで移動
    is_succeed: bool = False
    pos.pose.position.z += DISH_OFFSET
    pos.pose.orientation = Quaternion(0,0,1,0)
    while not is_succeed:
        is_succeed = op.cob_move_to(pos)
    #手を開く
    changeMode(mode=MODE.NORMAL)
    arm.k3Hand.movej(10)
    changeMode(mode=MODE.SLAVE)
    is_succeed = False
    #ディッシュの位置まで移動
    pos.pose.position.z -= DISH_OFFSET
    while not is_succeed:
        is_succeed = op.cob_move_to(pos)
    #手を閉じてディッシュを持ち上げる
    changeMode(mode=MODE.NORMAL)
    arm.k3Hand.movej(11)
    changeMode(mode=MODE.SLAVE)
    pos.pose.position.z += DISH_OFFSET
    is_succeed = False
    while not is_succeed:
        is_succeed = op.cob_move_to(pos)
    return True

