#!/usr/bin/env python3
# coding=utf-8

import os
import sys

import roslib.packages
from ultralytics import YOLO


def main(argv):
    model = YOLO("yolov8n.pt")
    # runsはパッケージ直下に作成
    model.train(data=f"./labs/data.yaml", epochs=400, project="./runs/labs/all")
    metrics = model.val()
    print(metrics)


if __name__ == "__main__":
    main(sys.argv)
