#!/usr/bin/env python3
# coding=utf-8
import os
import sys

from ultralytics import YOLO

model = YOLO("./runs/detect/train2/weights/best.pt")


def main(argv):
    try:
        dataset_type = argv[1]
    except IndexError:
        print("Please input dataset_type: pipette,dish or so")
        sys.exit(1)
    original_data = f"./{dataset_type}_datasets/original_data"
    annotation = f"./{dataset_type}_datasets/annotation"
    classes = annotation + "/classes.txt"
    if os.path.exists(classes):
        os.remove(classes)
    with open(classes, mode="w") as f:
        f.write("microPipette\n")
        f.write("microPipetteHead\n")
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
                results = model.predict(img_path, conf=0.7)
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
