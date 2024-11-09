#!/usr/bin/env python3
from ultralytics import YOLO
import pyrealsense2 as rs

import cv2

import numpy as np

import rospy

from geometry_msgs.msg import PoseStamped

import roslib.packages

import os

from screeninfo import get_monitors

pkg_path = roslib.packages.get_pkg_dir("mycobot_320_moveit")

model = YOLO(pkg_path + "/runs/detect/train2/weights/best.pt")

PIPETTE_HEAD_RADIUS = 0.01

zeros_x = 0
zeros_y = 0
zeros_z = 0


def decide_zeros(event, x, y, flags, params):
    if event == cv2.EVENT_LBUTTONDBLCLK:
        color_intr, depth_frame = params
        dist = depth_frame.get_distance(x, y)
        points = rs.rs2_deproject_pixel_to_point(color_intr, [x, y], dist)
        global zeros_x, zeros_y, zeros_z
        zeros_x = points[0]
        zeros_y = points[1]
        zeros_z = points[2]


def mesurement(event, x, y, flags, params):
    if event == cv2.EVENT_FLAG_LBUTTON:
        color_intr, depth_frame, xx, yy = params
        if x == 0.0 or y == 0.0:
            return
        dist = depth_frame.get_distance(x, y)
        points = rs.rs2_deproject_pixel_to_point(color_intr, [x, y], dist)
        txt_path = "measure9.txt"
        with open(os.path.join(pkg_path, txt_path), mode="a") as f:
            ln = len((open(os.path.join(pkg_path, txt_path))).readlines())
            x = ln % 3
            y = ln // 3
            f.write("{}\n".format(points[2]))
        rospy.loginfo("Saved")
        rospy.loginfo("x:{} y:{} z:{}".format(points[0], points[1], points[2]))


def draw_markers(img, x, y, z, color_intr):
    # x,y,zのカメラ座標系の位置を受け取り、そこを原点として1*1cmのグリッドを描画する
    for i in range(-5, 6):
        for j in range(-5, 6):
            try:
                points = rs.rs2_project_point_to_pixel(color_intr, [x + i, y + j, z])
                cv2.drawMarker(
                    img,
                    (int(points[0]), int(points[1])),
                    (0, 255, 0),
                    markerType=cv2.MARKER_CROSS,
                    markerSize=10,
                    thickness=1,
                    line_type=cv2.LINE_AA,
                )
            except Exception as e:
                continue
    return img


# 対象物体はバウンディングボックスの中心にいるものとする
# x,yのピクセル値を返す
def yolo_estimate(img):
    names = {"Head": 0, "Pipette": 1}
    try:
        results = model.predict(img, verbose=False, conf=0.6)
        conf = 0
        target = None
        for box in results[0].boxes:
            this_conf = box.conf.cpu().numpy()[0]
            this_label = int(box.cls[0].item())
            if this_label == names["Head"] and this_conf > conf:
                target = box
                conf = this_conf
        if target is None:
            return 0, 0
        xmin, ymin, xmax, ymax = target.xyxy[0].cpu().numpy()
        # わかりやすさのため、cv_imageにもボックスを表示させておく
        xmin, ymin, xmax, ymax = int(xmin), int(ymin), int(xmax), int(ymax)
        cv2.rectangle(img, (xmin, ymin), (xmax, ymax), (0, 255, 0), 2)

        label = "Head"
        conf = target.conf.cpu().numpy()[0]
        y = ymin - 15 if ymin - 15 > 15 else ymin + 15
        xg = (xmin + xmax) // 2
        yg = (ymin + ymax) // 2
        return xg, yg
    except IndexError as e:
        return 0, 0


def main():
    rospy.init_node("target_estimation", anonymous=True)
    pub = rospy.Publisher("target_estimation", PoseStamped, queue_size=10)
    # カメラの設定
    conf = rs.config()
    conf.enable_stream(rs.stream.color, 640, 480, rs.format.bgr8, 30)
    # 距離
    conf.enable_stream(rs.stream.depth, 640, 480, rs.format.z16, 30)

    monitor = get_monitors()[0]
    screen_width = monitor.width
    screen_height = monitor.height

    # stream開始
    pipe = rs.pipeline()
    profile = pipe.start(conf)

    # 内部パラメータの読み込み
    color_intr = rs.video_stream_profile(
        profile.get_stream(rs.stream.color)
    ).get_intrinsics()

    # カメラ位置の違いから、そのままだとDeepth_frame.get_distance(new_x, new_y)pthとColorの画像がずれているので合わせる
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
        x, y = yolo_estimate(color_image)
        color_image = draw_markers(color_image, zeros_x, zeros_y, zeros_z, color_intr)
        cv2.imshow("image", color_image)
        cv2.waitKey(1)
        # x , y = 0,0のときはデータ取得失敗している
        cv2.setMouseCallback("image", decide_zeros, (color_intr, depth_frame))
        cv2.setMouseCallback("image", mesurement, (color_intr, depth_frame, x, y))


if __name__ == "__main__":
    main()
