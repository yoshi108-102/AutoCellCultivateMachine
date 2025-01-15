#!/usr/bin/env python3
import os

import roslib.packages
import rospy
from k3hand import k3hand

import yaml

PKG_PATH = roslib.packages.get_pkg_dir("core_moveit")

class K3HandinMyCobot:
    def __init__(self,dev_file: str = "/dev/ttyUSB1"):
        self.hand = k3hand(dev_file)
        self.hand.enable_all()
        yaml_path = os.path.join(PKG_PATH,"yaml","k3hand_points.yaml")
        with open(yaml_path,"r") as f:
            self.point_data = yaml.safe_load(f)
        self.hand.send_speeds([30]*8)
    def movej(self,id:int):
        try:
            angles = self.point_data[f"p{id}"][0]
            self.hand.send_angles(angles)
        except Exception as e:
            rospy.logerr(e)
            return
def main():
    k3hand = K3HandinMyCobot()
    k3hand.movej(0)
if __name__ == "__main__":
    main()