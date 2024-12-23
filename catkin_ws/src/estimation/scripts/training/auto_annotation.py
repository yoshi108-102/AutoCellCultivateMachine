#!/usr/bin/env python3
# coding=utf-8
import os
import sys

from ultralytics import YOLO


def main(argv):
    try:
        dataset_type = argv[1]
    except IndexError:
        print("Please input dataset_type: pipette,dish or so")
        sys.exit(1)
    original_data = f"./{dataset_type}_datasets/original_data"
    annotation = f"./{dataset_type}_datasets/annotation"
    model = YOLO("./runs/lab_dish/all/train/weights/best.pt")
    annotationed_data = set()
    for root, _, files in os.walk(annotation):
        for file in files:
            annotationed_data.add(os.path.join(root, file))
    for root, dirs, list in os.walk(original_data):
        for file in list:
            img_path = os.path.join(root, file)
            if os.path.splitext(img_path)[-1] == ".png":
                txt_path = img_path.replace("original_data", "annotation").replace(
                    "png", "txt"
                )
                if txt_path in annotationed_data:
                    print(f"{txt_path} already annotated")
                else:
                    print(img_path + "\n")
                    results = model.predict(img_path, conf=0.8)
                    for box in results[0].boxes:
                        print(box)
                        label = int(box.cls[0].item())
                        xmin, ymin, xmax, ymax = box.xyxy.cpu().numpy()[0]
                        w, h = 640, 480
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
    main(sys.argv)
