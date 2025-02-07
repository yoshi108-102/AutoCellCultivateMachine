#!/usr/bin/env python3
import os
import rospy
import roslib.packages

import cv2
import matplotlib.pyplot as plt
from ultralytics import YOLO
import numpy as np

PKG_PATH = roslib.packages.get_pkg_dir("experiment")

def main():
    pipette_data_path = os.path.join(PKG_PATH, "dataset", "experiment1", "experiment_pipette_datasets", "original_data")
    train_data_size = [200*(i+1) for i in range(5)]
    thresholds = [0.5 + 0.05 * i for i in range(10)]
    labels = {"pipette": 0, "dish": 1}
    for data_size in train_data_size:
        yolo_path = os.path.join(os.path.expanduser("~"), "yolo_dataset", "runs","labs", f"{data_size}","train","weights","best.pt")
        yolo = YOLO(yolo_path)
        res = yolo.val()
if __name__ == "__main__":
    main()
    