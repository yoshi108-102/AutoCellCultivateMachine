#!/usr/bin/env python3
import math
import os
import random

import cv2
import roslib.packages
import rospy
from cv_bridge import CvBridge, CvBridgeError
from pymycobot.mycobot import MyCobot
# realsenseのカメラ画像を取得するためのライブラリ
from sensor_msgs.msg import Image

filename = ""
count = 0
cv_image = None


def count_files(filename: str):
    count = 0
    for i in os.walk("./" + filename + "_datasets/original_data"):
        count += len(i[2])
    return count


def callback(event):
    default = [0, 0, 0, 0, 0, 0]
    global count
    global cv_image
    global filename
    if cv_image is None:
        print("you are not start realsense launch")
        return
    if filename == "":
        print("decide file name")
        return
    cv2.imwrite(f"./{filename}_datasets/original_data/{filename}_{count}.png", cv_image)
    rospy.loginfo(f"save {filename}_{count}.png")
    rospy.sleep(1)
    count += 1


def image_callback(msg: Image):
    global cv_image
    bridge = CvBridge()
    try:
        cv_image = bridge.imgmsg_to_cv2(msg, "bgr8")
        cv2.imshow("image", cv_image)
        cv2.waitKey(1)
    except CvBridgeError as e:
        print(e)


def main():
    rospy.init_node("mycobot_testdata_maker", anonymous=True)
    r = input("Do you want to take pictures? (y/n): ")
    rospy.Subscriber("/camera/color/image_raw", Image, image_callback)
    if r == "y":
        global filename
        filename = input("file name :")
        count = count_files(filename)
        rospy.Timer(rospy.Duration(0.3), callback)
    rospy.spin()


if __name__ == "__main__":
    main()
