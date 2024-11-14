#!/usr/bin/env python3
# coding=utf-8

import roslib.packages
import sys


from ultralytics import YOLO
import os
def main(argv):
    try:
        dataset_type = argv[1]
    except IndexError:
        print("Please input dataset_type: pipette,dish or so")
        sys.exit(1)
    model = YOLO("yolov8n.pt")
    # runsはパッケージ直下に作成
    model.train(
        data=f"./{dataset_type}_datasets/data.yaml", epochs=400, project="./runs/detect"
    )
    metrics = model.val()
    print(metrics)
if __name__ == "__main__":
    main(sys.argv)
