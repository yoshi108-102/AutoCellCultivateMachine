#!/usr/bin/env python3
# coding=utf-8
import os

from ultralytics import YOLO

import roslib.packages

PKG_DIR = roslib.packages.get_pkg_dir("mycobot_320_moveit")
model = YOLO(PKG_DIR + "/runs/detect/train/weights/best.pt")


def main():
    original_data = PKG_DIR + "/datasets/original_data"
    annotation = PKG_DIR + "/datasets/annotation"
    classes = annotation + "/classes.txt"
    if os.path.exists(classes):
        os.remove(classes)
    with open(classes, mode="w") as f:
        f.write("Head\n")
        f.write("Pipette\n")
    annotationed_data = set()
    for root, _, files in os.walk(annotation):
        for file in files:
            if len(open(os.path.join(root, file)).readlines()) == 2:
                annotationed_data.add(os.path.join(root, file))
    for root, dirs, list in os.walk(original_data):
        for file in list:
            img_path = os.path.join(root, file)
            if os.path.splitext(img_path)[-1] == ".png":
                txt_path = img_path.replace("original_data", "annotation").replace(
                    "png", "txt"
                )
                if txt_path in annotationed_data:
                    continue
                print(img_path + "\n")
                results = model.predict(img_path, conf=0.55)
                for box in results[0].boxes:
                    label = int(box.cls[0].item())
                    if label == 0:
                        continue
                    xmin, ymin, xmax, ymax = box.xyxy.cpu().numpy()[0]
                    w, h = 854, 480
                    xmin /= w
                    xmax /= w
                    ymin /= h
                    ymax /= h
                    xg = xmin + (xmax - xmin) / 2
                    yg = ymin + (ymax - ymin) / 2
                    with open(txt_path, mode="a") as f:
                        text = "{} {} {} {} {}\n".format(
                            label, xg, yg, xmax - xmin, ymax - ymin
                        )
                        f.write(text)


if __name__ == "__main__":
    main()
