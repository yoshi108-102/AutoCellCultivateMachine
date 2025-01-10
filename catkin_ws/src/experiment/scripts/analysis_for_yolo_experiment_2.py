#!usr/bin/env python3
import os
import sys

import pyrealsense2 as rs
import roslib.packages
import rospy
import yaml
from ultralytics import YOLO

PKG_PATH = roslib.packages.get_pkg_dir("experiment")
HOME = os.path.expanduser("~")
YOLO_PATH = os.path.join(
    HOME, "yolo_dataset", "runs", "labs", "all", "weights", "best.pt"
)
YAML_PATH = os.path.join(PKG_PATH, "analysis", "experiment2.yaml")


def main(argv):
    distances = [0.06 * i for i in range(1, 6)]
    angles = [0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180]
    model = YOLO(YOLO_PATH)
    rs_intr = rs.intrinsics()
    for dist in distances:
        for angle in angles:
            target_path = os.path.join(
                PKG_PATH,
                "dataset",
                "experiment2",
                str(dist) + "meter",
                str(angle) + "degree",
            )
            if os.path.exists(target_path) == False:
                rospy.logerr("No such directory: %s" % target_path)
                return
            with open(YAML_PATH, "rw") as f:
                analysis = yaml.safe_load(f)
            for i in len(os.listdir(target_path)):
                img_path = os.path.join(target_path, str(i) + ".png")
                result = model.predict(img_path, verbose=False, conf=0.8)
                for box in result[0].boxes:
                    xmin, ymin, xmax, ymax = box.xyxy[0].cpu().numpy()
                    xg, yg = (xmin + xmax) / 2, (ymin + ymax) / 2
                    zg = analysis[str(dist)][str(angle)]["camera_depth"][i]
                    x, y, z = rs.rs2_deproject_pixel_to_point(rs_intr, [xg, yg], zg)
                analysis[dist][angle].append(result)


if __name__ == "__main__":
    main(sys.argv)
