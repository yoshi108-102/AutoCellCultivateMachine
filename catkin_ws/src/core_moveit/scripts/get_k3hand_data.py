import os

import roslib.packages
import rospy
from cobotta.cobotta_arm import CobottaArmBcapInterface as Cobotta
from cobotta.cobotta_k3hand import K3HandinCobotta as K3Hand

import yaml


def main():
    rospy.init_node("get_k3hand_data")
    cb = Cobotta()
    cb.controller_connect()
    cb.add_k3hand()
    angles = {
            f"p{i}" : [] for i in range(40)
    }
    for i in range(40):
        cb.k3Hand.movej(i)
        rospy.sleep(1)
        res = cb.k3Hand.curPos()
        print(res)
if __name__=="__main__":
    main()