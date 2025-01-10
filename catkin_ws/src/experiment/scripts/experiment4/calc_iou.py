#!/usr/bin/env python3
import os

import cv2
import matplotlib.pyplot as plt
import numpy as np
import roslib.packages
import rospy

PKG_PATH = roslib.packages.get_pkg_dir("experiment")

def main():
    dataset = os.path.join(PKG_PATH, "dataset","experiment4","detect_hand")
    iou_average = 0
    file_num = 0
    x = [15*(i+1) for i in range(10)]
    x_num = [0] * 10
    x_sum = [0]*10
    for cur,dirs,files in os.walk(dataset):
        file_num += len(files)
        if len(dirs) != 0:
            continue
        
        for file in files:
            if file.endswith(".jpg"):
                filtered_path = cur.replace("detect_hand","filtered_hand")
                #2値化
                img_1 = cv2.imread(os.path.join(cur,file))
                img_1 = cv2.cvtColor(img_1, cv2.COLOR_BGR2GRAY)
                img_1 = cv2.threshold(img_1, 0, 255, cv2.THRESH_BINARY)[1]
                img_2 = cv2.imread(os.path.join(filtered_path,file))
                img_2 = cv2.cvtColor(img_2, cv2.COLOR_BGR2GRAY)
                img_2 = cv2.threshold(img_2, 0, 255, cv2.THRESH_BINARY)[1]
                #IOU計算
                intersection = cv2.bitwise_and(img_1, img_2)
                union = cv2.bitwise_or(img_1, img_2)
                """ cv2.imshow("detect_hand",img_1)
                cv2.imshow("filtered_hand",img_2) """
                """  cv2.imshow("intersection",intersection)
                cv2.imshow("union",union) """
                cv2.waitKey(30)
                iou = cv2.countNonZero(intersection) / cv2.countNonZero(union)
                paht_list,id = list(os.path.split(cur))
                print(id)
                x_sum[int(id)] += iou
                x_num[int(id)] += 1
                iou_average += iou
                print(f"{file}: {iou}")
    iou_average /= file_num
    y = [x_sum[i] / x_num[i] for i in range(10)]
    plt.plot(x,y)
    plt.scatter(x,y,color="white",s=100)
    plt.axhline(y=0,color="black",linewidth=0.5)
    plt.title("accurancy level of arm detection")
    plt.xlabel("angle between camera center and arm [pixel (640*480)]")
    plt.ylabel("IoU between detected arm and real arm ")
    plt.savefig(os.path.join(PKG_PATH,"analysis","experiment4","iou_and_angle.png"))
    print(f"average: {iou_average}")
if __name__ == "__main__":
    main()
    
                
                