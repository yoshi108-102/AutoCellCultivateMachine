#!/usr/bin/env python3
import pyrealsense2 as rs

import cv2

import numpy as np

from geometry_msgs.msg import PoseStamped

import roslib.packages

import yaml

pkg_path = roslib.packages.get_pkg_dir('mycobot_320_moveit')

count = 10
point_ave = [0,0,0]
def mauseevents(event,x,y,flags,params):
    global point_ave,count
    if event != cv2.EVENT_LBUTTONDOWN:
        return
    color_intr,depth_frame = params
    dist = depth_frame.get_distance(x, y)
    points = rs.rs2_deproject_pixel_to_point(color_intr, [x, y], dist)
    point_ave[0] += points[0]
    point_ave[1] += points[1]
    point_ave[2] += points[2]
    print(points,x,y)
    count -= 1
def main():
    global point_ave,count
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
    while count > 0:
        frames = pipe.wait_for_frames()
        aligned_frames = align.process(frames)
        # RGB画像
        color_frame = aligned_frames.get_color_frame()
        # Depth画像
        depth_frame = aligned_frames.get_depth_frame()
        
        color_image = np.asanyarray(color_frame.get_data())
        cv2.imshow('color', color_image)
        cv2.waitKey(1)
        # x , y = 0,0のときはデータ取得失敗している
        cv2.setMouseCallback('color', mauseevents, (color_intr,depth_frame))
    point_ave = [point_ave[i]/10 for i in range(3)]
    print(point_ave)
    yaml_path = pkg_path + "/config/mycobot_position.yaml"
    with open(yaml_path, 'rb') as f:
        yml = yaml.safe_load(f)
    yml["position"]["x"] = point_ave[0]
    yml["position"]["y"] = point_ave[1]
    yml["position"]["z"] = point_ave[2]
    with open(yaml_path, 'w') as f:
        yaml.safe_dump(yml, f)
if __name__ == '__main__':
    main()