#!/usr/bin/env python3
from ultralytics import YOLO
import pyrealsense2 as rs

import cv2

import numpy as np

import rospy

from geometry_msgs.msg import PoseStamped

import roslib.packages

from screeninfo import get_monitors
pkg_path = roslib.packages.get_pkg_dir('mycobot_320_moveit')

model = YOLO(pkg_path+"/runs/detect/train2/weights/best.pt")

PIPETTE_HEAD_RADIUS = 0.01
    
#対象物体はバウンディングボックスの中心にいるものとする
#x,yのピクセル値を返す
def yolo_estimate(img):
    names = {"Head":0,"Pipette":1}
    try:
        results = model.predict(img,verbose=False,conf=0.6)
        conf = 0
        target = None
        for box in results[0].boxes:
            this_conf = box.conf.cpu().numpy()[0]
            this_label = int(box.cls[0].item())
            if this_label == names["Head"] and this_conf > conf:
                target = box
                conf = this_conf
        if target is None:
            return 0,0
        xmin, ymin, xmax, ymax = target.xyxy[0].cpu().numpy()
        #わかりやすさのため、cv_imageにもボックスを表示させておく
        xmin, ymin,xmax,ymax = int(xmin),int(ymin),int(xmax),int(ymax)
        cv2.rectangle(img, (xmin, ymin), (xmax, ymax), (0, 255, 0), 2)
        
        label = "Head"
        conf = target.conf.cpu().numpy()[0]
        y = ymin - 15 if ymin - 15 > 15 else ymin + 15
        cv2.putText(img, label, (xmin, y), cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 255, 0), 2)
        cv2.putText(img, str(conf), (xmin, y+25), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
        xg = (xmin + xmax) // 2
        yg = (ymin + ymax) // 2
        return xg,yg
    except IndexError as e:
        return 0,0
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
    while not rospy.is_shutdown():
        frames = pipe.wait_for_frames()
        aligned_frames = align.process(frames)
        # RGB画像
        color_frame = aligned_frames.get_color_frame()
        # Depth画像
        depth_frame = aligned_frames.get_depth_frame()
        
        color_image = np.asanyarray(color_frame.get_data())
        x,y = yolo_estimate(color_image)
        # x , y = 0,0のときはデータ取得失敗している
        if x != 0 or y != 0:
            pose = PoseStamped()
            pose.header.stamp = rospy.Time.now()
            z = depth_frame.get_distance(x,y) + PIPETTE_HEAD_RADIUS
            points = rs.rs2_deproject_pixel_to_point(color_intr , (x,y), z)
            if abs(points[0]) < 0.01 and abs(points[1]) < 0.01 and abs(points[2]) < 0.01:
                continue
            pose.header.frame_id = "world"
            pose.pose.position.x = points[0]
            pose.pose.position.y = points[1]
            pose.pose.position.z = points[2]
            #とりあえず向きなどは固定
            pose.pose.orientation.x = 0
            pose.pose.orientation.y = 0
            pose.pose.orientation.z = 0
            pose.pose.orientation.w = 1.0
            print(points)
            pub.publish(pose)
            txt = "PipetteHead"
            cv2.putText(color_image, txt, (0,50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,255,0), 2)
            txt = "X [m]: " + str(round(points[0],3))
            cv2.putText(color_image, txt, (0,80), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,255,0), 2)
            txt = "Y [m]: " + str(round(points[1],3))
            cv2.putText(color_image, txt, (0,110), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,255,0), 2)
            txt = "Z [m]: " + str(round(points[2],3))
            cv2.putText(color_image, txt, (0,140), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,255,0), 2)
        cv2.imshow('color', color_image)
        cv2.waitKey(1)
if __name__ == '__main__':
    main()