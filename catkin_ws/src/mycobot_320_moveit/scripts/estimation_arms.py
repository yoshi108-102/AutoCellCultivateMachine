#!/usr/bin/env python3
from ultralytics import YOLO
import pyrealsense2 as rs

import cv2

import numpy as np

import rospy

from geometry_msgs.msg import PoseStamped

import roslib.packages

import sys
import os
from sys import platform
from openpose import pyopenpose as op

pkg_path = roslib.packages.get_pkg_dir('mycobot_320_moveit')

model = YOLO(pkg_path+"/runs/detect/train2/weights/best.pt")

PIPETTE_HEAD_RADIUS = 0.01

def main():
    rospy.init_node("target_estimation",anonymous=True)
    pub = rospy.Publisher("target_estimation",PoseStamped,queue_size=10)
    # カメラの設定
    conf = rs.config()
    conf.enable_stream(rs.stream.color, 640, 480, rs.format.bgr8, 30)
    # 距離
    conf.enable_stream(rs.stream.depth, 640, 480, rs.format.z16, 30)

    # stream開始
    pipe = rs.pipeline()
    profile = pipe.start(conf)
    
    #内部パラメータの読み込み
    color_intr = rs.video_stream_profile(profile.get_stream(rs.stream.color)).get_intrinsics()
    
    #カメラ位置の違いから、そのままだとDepthとColorの画像がずれているので合わせる
    align_to = rs.stream.color
    align = rs.align(align_to)
    
    oparams = dict()
    oparams["model_folder"] = "/home/tw017/openpose/models"
    # Starting OpenPose
    opWrapper = op.WrapperPython()
    opWrapper.configure(oparams)
    opWrapper.start()
    poseModel = op.PoseModel.BODY_25
    indexMap = dict()
    for key,value in op.getPoseBodyPartMapping(poseModel).items():
        indexMap[value] = key
    print(indexMap)
    while not rospy.is_shutdown():
        frames = pipe.wait_for_frames()
        aligned_frames = align.process(frames)
        # RGB画像
        color_frame = aligned_frames.get_color_frame()
        # Depth画像
        depth_frame = aligned_frames.get_depth_frame()
        
        color_image = np.asanyarray(color_frame.get_data())
        
         # Process Image
        datum = op.Datum()
        datum.cvInputData = color_image
        opWrapper.emplaceAndPop(op.VectorDatum([datum]))
        
        cv2.imshow("OpenPose 1.7.0 - Tutorial Python API", datum.cvOutputData)
        cv2.waitKey(1)
        
if __name__ == '__main__':
    main()