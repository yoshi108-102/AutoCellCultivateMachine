#!/usr/bin/env python3
# coding=utf-8

import roslib.packages

pkg_dir = roslib.packages.get_pkg_dir('mycobot_320_moveit')

from ultralytics import YOLO
model = YOLO("yolov8n.pt")
# runsはパッケージ直下に作成
model.train(data=pkg_dir + "/datasets/data.yaml", epochs=400,project=pkg_dir + "/runs/detect")
metrics = model.val()