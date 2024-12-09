from ultralytics import YOLO

model = YOLO("runs/detect/train/weights/best.pt")

import cv2

import glob

import matplotlib.pyplot as plt

path_list = glob.glob("datasets/test/images/*.png")

names = model.names

print(names)

for path in path_list:
    img = cv2.imread(path)
    preds = model.predict(path)
    for box in preds[0].boxes:
        label = names[box.cls.cpu().numpy()[0]]
        conf = box.conf.cpu().numpy()[0]
        xmin, ymin, xmax, ymax = box.xyxy.cpu().numpy()[0]
        xmin, ymin, xmax, ymax = int(xmin), int(ymin), int(xmax), int(ymax)
        
        cv2.rectangle(img, (xmin, ymin), (xmax, ymax), (0, 255, 0), 2)
        
        y = ymin - 15 if ymin - 15 > 15 else ymin + 15
        cv2.putText(img, label, (xmin, y), cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 255, 0), 2)
        cv2.putText(img, str(conf), (xmin, y+25), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
    #imgを表示
    plt.figure()
    plt.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
    plt.axis('off')
    plt.show()
