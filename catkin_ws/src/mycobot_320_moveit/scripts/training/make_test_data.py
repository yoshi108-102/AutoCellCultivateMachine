#!/usr/bin/env python3
import rospy
import roslib.packages

pkg_dir = roslib.packages.get_pkg_dir("mycobot_320_moveit")
# realsenseのカメラ画像を取得するためのライブラリ
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
import cv2
from pymycobot.mycobot import MyCobot
import random
import math
import os


def count_files():
    count = 0
    for i in os.walk(pkg_dir + "/datasets/original_data"):
        count += len(i[2])
    return count


count = count_files()
cv_image = None
filename = ""


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
    cv2.imwrite(pkg_dir + f"/datasets/original_data/{filename}_{count}.png", cv_image)
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
        rospy.Timer(rospy.Duration(0.3), callback)
    rospy.spin()


if __name__ == "__main__":
    main()
