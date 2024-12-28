#!/usr/bin/env python3
import math
import os

import cv2
import cv_bridge
import numpy as np
import pyrealsense2 as rs
import roslib.packages
import rospy
import yaml
from geometry_msgs.msg import Pose, PoseArray, PoseStamped
from openpose import pyopenpose as op
from screeninfo import get_monitors
from sensor_msgs.msg import Image
from ultralytics import YOLO
from visualization_msgs.msg import MarkerArray

pkg_path = roslib.packages.get_pkg_dir("experiment")

HOME_DIR = os.path.expanduser("~")
YAML_PATH = os.path.join(pkg_path,"analysis","experiment2_2_pipette.yaml")
YOLO_PATH = os.path.join(HOME_DIR,"yolo_dataset","runs","labs","all","train","weights","best.pt")
class PictureTaker:
    def __init__(self):
        self.camera_init()
        self.take_cnt = 0
        self.yamlData = {
           round(j*50,3):{i*15:{"points":[]} for i in range(1,11)} for j in range(1,6)
        }
        self.pipetteModel = YOLO(YOLO_PATH)
        self.pipettePose = PoseStamped()
        rospy.loginfo("Initialized PictureTaker")
        rospy.loginfo(self.yamlData.keys())
    def camera_init(self):
        self.PIPETTE_HEAD_RADIUS = 0.01
        self.conf = rs.config()
        self.conf.enable_stream(rs.stream.color, 640, 480, rs.format.bgr8, 30)
        self.conf.enable_stream(rs.stream.depth, 640, 480, rs.format.z16, 30)
        self.pipe = rs.pipeline()
        self.profile = self.pipe.start(self.conf)
        self.color_intr = rs.video_stream_profile(
            self.profile.get_stream(rs.stream.color)
        ).get_intrinsics()
        self.align_to = rs.stream.color
        self.align = rs.align(self.align_to)

    # （RGB画像,Depthデータ）を座標を合わせた状態で返す
    def getRSImages(self):
        frames = self.pipe.wait_for_frames()
        aligned_frames = self.align.process(frames)
        # RGB画像
        color_frame = aligned_frames.get_color_frame()
        # Depth画像
        depth_frame = aligned_frames.get_depth_frame()
        color_image = np.asanyarray(color_frame.get_data())
        return color_image, depth_frame

    def estimatePipettePose(self, img):
        names = {"pipette": 0, "dish": 1}
        try:
            results = self.pipetteModel.predict(img, verbose=False, conf=0.6)
            conf = 0
            target = None
            for box in results[0].boxes:
                this_conf = box.conf.cpu().numpy()[0]
                this_label = int(box.cls[0].item())
                if this_label == names["pipette"] and this_conf > conf:
                    target = box
                    conf = this_conf
            if target is None:
                return 0, 0
            xmin, ymin, xmax, ymax = target.xyxy[0].cpu().numpy()
            # わかりやすさのため、cv_imageにもボックスを表示させておく
            xmin, ymin, xmax, ymax = int(xmin), int(ymin), int(xmax), int(ymax)
            cv2.rectangle(img, (xmin, ymin), (xmax, ymax), (0, 255, 0), 2)

            label = "pipette"
            conf = target.conf.cpu().numpy()[0]
            y = ymin - 15 if ymin - 15 > 15 else ymin + 15
            cv2.putText(
                img, label, (xmin, y), cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 255, 0), 2
            )
            cv2.putText(
                img,
                str(conf),
                (xmin, y + 25),
                cv2.FONT_HERSHEY_SIMPLEX,
                1,
                (0, 255, 0),
                2,
            )
            xg = (xmin + xmax) // 2
            yg = (ymin + ymax) // 2
            return xg, yg
        except IndexError as e:
            return 0, 0

    def calcWorldPose(self, depth_frame, x, y):
        if x == 0 and y == 0:
            return None
        z = depth_frame.get_distance(x, y) + self.PIPETTE_HEAD_RADIUS
        points = rs.rs2_deproject_pixel_to_point(self.color_intr, (x, y), z)
        if abs(points[0]) < 0.01 and abs(points[1]) < 0.01 and abs(points[2]) < 0.01:
            return None
        return points

    def displayPipettePose(self, color_image):
        center=(320,240)
        for radius in range(50,300,50):
            radius = int(radius)
            color = (0,255,0)
            thickness = 1
            for angle in range(0,360,15):
                radian = math.radians(angle)
                start_point = center
                end_point=(
                    int(center[0] + radius * math.cos(radian)),
                    int(center[1] + radius * math.sin(radian))
                )
                if angle == 360 - 15 or angle == 360 - 150:
                    color = (0,0,255)
                else:
                    color = (0,255,0)
                cv2.line(color_image,start_point,end_point,color,thickness)
            color = (0,255,0)
            cv2.circle(color_image,center,radius,color,thickness)
    def pipetteChecker(self, color_image, depth_frame):
        x, y = self.estimatePipettePose(color_image)
        points = self.calcWorldPose(depth_frame, x, y)
        self.displayPipettePose(color_image)
        
    def mouseEvent(self,event, x, y, flags, param):
        distances:list = [50*i for i in range(3,6)]
        angles:list = [90,105,120,135,150]
        take_num = 5
        id = self.take_cnt//(take_num * len(angles))
        angle_id = (self.take_cnt % (take_num * len(angles))) // take_num
        dir_path = os.path.join(pkg_path,"dataset","experiment2_2","pipette",str(distances[id]) + "pixel",str(angles[angle_id])+"degree")
        with open(YAML_PATH,"r") as f:
            self.yamlData = yaml.safe_load(f)
        f.close()
        if os.path.exists(dir_path) == False:
            os.makedirs(dir_path)
        if event == cv2.EVENT_LBUTTONDOWN:
            try:
                color_image, depth_frame = self.getRSImages()
                x,y = self.estimatePipettePose(color_image)
                points = self.calcWorldPose(depth_frame,x,y)
                if points == None:
                    rospy.logwarn("No points detected")
                    return
                length = len(os.listdir(dir_path))
                cv2.imwrite(os.path.join(dir_path,str(length)+".png"),color_image)
                self.take_cnt += 1
                with open(YAML_PATH,"w") as f:
                        self.yamlData[distances[id]][angles[angle_id]]["points"].append(points)
                        yaml.dump(self.yamlData,f)
                rospy.loginfo("Saved image to " + os.path.join(dir_path,str(length)+".png"))
            except Exception as e:
                rospy.logwarn("No such key in yamlData or finished taking pictures or something else")
                exit()
        elif event == cv2.EVENT_RBUTTONDOWN:
            exit()
            rospy.loginfo(
                "next image will be saved to "+os.path.join(dir_path,str(angles[self.take_cnt%take_num])+".png")
            )
               

def main():
    rospy.init_node("target_estimation", anonymous=True)
    pTaker = PictureTaker()
    cv2.namedWindow("color_image",cv2.WINDOW_NORMAL)
    
    cv2.setMouseCallback("color_image", pTaker.mouseEvent)
    while not rospy.is_shutdown():
        color_image, depth_frame = pTaker.getRSImages()
        image = cv_bridge.CvBridge().cv2_to_imgmsg(color_image, "bgr8")
        try:
            pTaker.pipetteChecker(color_image, depth_frame)
        except Exception as e:
            rospy.logwarn(e)
        color_image = cv2.resize(color_image,(1280,960))
        cv2.imshow("color_image", color_image)
        cv2.waitKey(1)
    cv2.destroyAllWindows()
        
if __name__ == "__main__":
    main()

    
e