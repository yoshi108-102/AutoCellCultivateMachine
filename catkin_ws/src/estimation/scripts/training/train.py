#!/usr/bin/env python3
# coding=utf-8

import roslib.packages



from ultralytics import YOLO
import os

model = YOLO("yolov8n.pt")
# runsはパッケージ直下に作成
model.train(
    data="./datasets/data.yaml", epochs=400, project="./runs/detect"
)
metrics = model.val()
