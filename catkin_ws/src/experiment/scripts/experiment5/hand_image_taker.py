#!/usr/bin/env python3
import math
import os
import time

import cv2
import cv_bridge
import numpy as np
import pyrealsense2 as rs
import roslib.packages
import rospy
from geometry_msgs.msg import Pose, PoseArray, PoseStamped, Quaternion
from openpose import pyopenpose as op
from screeninfo import get_monitors
from sensor_msgs.msg import Image
from std_msgs.msg import String
from ultralytics import YOLO

from hand_data import HandDetector

pkg_path = roslib.packages.get_pkg_dir("experiment")

HOME_DIR = os.path.expanduser("~")
class CVEstimator:
    def __init__(self):
        self.openpose_init()
        self.camera_init()
        self.yolo_init()
        self.pipettePose = PoseStamped()
        self.pipettePosePublisher = rospy.Publisher(
            "target_estimation", PoseStamped, queue_size=10
        )
        self.imageRawPublisher = rospy.Publisher(
            "camera/color/image_raw", Image, queue_size=10
        )
        self.handDetertor = HandDetector()
        self.take_cnt = 0
        path = os.path.join(pkg_path,"dataset","experiment4")
        for _,_,files in os.walk(path):
            self.take_cnt += len(files)
        self.take_cnt //=2
        print(self.take_cnt)
        self.start_time = 0
        self.hand_points = []

    def yolo_init(self):
        self.pipetteModel = YOLO(
            HOME_DIR + "/yolo_dataset/runs/labs/all/train/weights/best.pt"
        )

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

    def openpose_init(self):
        self.opWrapper = op.WrapperPython()
        self.oparams = dict()
        self.oparams["model_folder"] = "/home/tw017/openpose/models"
        self.opWrapper.configure(self.oparams)
        self.opWrapper.start()
        self.poseModel = op.PoseModel.BODY_25
        tmp = op.getPoseBodyPartMapping(self.poseModel)
        self.poseMap = dict()
        for key, value in tmp.items():
            self.poseMap[value] = key
        print(self.poseMap)
        self.datum = op.Datum()

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

    # 対象物体はバウンディングボックスの中心にいるものとする
    # x,yのピクセル値を返す
    def estimatePipettePose(self, img):
        names = {"Head": 0, "Pipette": 1}
        try:
            results = self.pipetteModel.predict(img, verbose=False, conf=0.6)
            conf = 0
            target = None
            for box in results[0].boxes:
                this_conf = box.conf.cpu().numpy()[0]
                this_label = int(box.cls[0].item())
                if this_label == names["Pipette"] and this_conf > conf:
                    target = box
                    conf = this_conf
            if target is None:
                return 0, 0
            xmin, ymin, xmax, ymax = target.xyxy[0].cpu().numpy()
            # わかりやすさのため、cv_imageにもボックスを表示させておく
            xmin, ymin, xmax, ymax = int(xmin), int(ymin), int(xmax), int(ymax)
            cv2.rectangle(img, (xmin, ymin), (xmax, ymax), (0, 255, 0), 2)

            label = "Pipette"
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

    def publishPipettePose(self, depth_frame, points):
        if points is None:
            return
        self.pipettePose.header.frame_id = "PipetteHead"
        self.pipettePose.header.stamp = rospy.Time.now()
        self.pipettePose.pose.position.x = points[0]
        self.pipettePose.pose.position.y = points[1]
        self.pipettePose.pose.position.z = points[2]
        # とりあえず向きなどは固定
        self.pipettePose.pose.orientation.x = 0
        self.pipettePose.pose.orientation.y = 0
        self.pipettePose.pose.orientation.z = 0
        self.pipettePose.pose.orientation.w = 1.0

        self.pipettePosePublisher.publish(self.pipettePose)

    def displayPipettePose(self, color_image):
        center = (320, 240)
        for radius in range(50, 300, 50):
            radius = int(radius)
            color = (0, 255, 0)
            thickness = 1
            for angle in range(0, 360, 15):
                radian = math.radians(angle)
                start_point = center
                end_point = (
                    int(center[0] + radius * math.cos(radian)),
                    int(center[1] + radius * math.sin(radian)),
                )
                cv2.line(color_image, start_point, end_point, color, thickness)
            color = (0, 255, 0)
            cv2.circle(color_image, center, radius, color, thickness)
        return color_image

    # pipetteを検出し、位置を推定するe
    def pipetteChecker(self, color_image, depth_frame):
        x, y = self.estimatePipettePose(color_image)
        points = self.calcWorldPose(depth_frame, x, y)
        self.publishPipettePose(depth_frame, points)
        self.displayPipettePose(color_image)

    def estimationHumanPose(self, color_image, depth_frame):
        detect_result = self.handDetertor.detect(color_image)
        w, h = 640, 480
        pose_array = PoseArray()
        for i in range(2):
            try:
                conf = detect_result.handedness[i][0].score
                if conf < 0.8:
                    rospy.logwarn("Confidence is low")
                    continue
            except IndexError:
                rospy.logwarn("No hand detected")
                continue
            for j in range(21):
                landmark = detect_result.hand_landmarks[i][j]
                pose = Pose()
                x = int(landmark.x * w)
                y = int(landmark.y * h)
                z = depth_frame.get_distance(x, y)
                points = rs.rs2_deproject_pixel_to_point(self.color_intr, (x, y), z)
                pose.position.x = points[0]
                pose.position.y = points[1]
                pose.position.z = points[2]
                pose.orientation = Quaternion(0, 0, 0, 1)
                pose_array.poses.append(pose)
            rospy.loginfo(f"pose_array: {pose_array}")
            rospy.Publisher("hand_estimation", PoseArray, queue_size=10).publish(
                pose_array
            )
        return

    # 手首、肘、肩の位置情報だけ抽出する
    # とりあえず右手だけ
    def extractArmData(self, poseKeypoints, conf=0.2):
        if poseKeypoints is None:
            return None
        armData = dict()
        target = ["RWrist", "RElbow", "RShoulder", "LWrist", "LElbow", "LShoulder"]
        for e in target:
            if poseKeypoints[0][self.poseMap[e]][2] < conf:
                continue
            x, y, c = poseKeypoints[0][self.poseMap[e]][0:3]
            x = int(x)
            y = int(y)
            armData[e] = [x, y]
        return armData

    # 手首、肘、肩の位置情報をpublishする
    def publishArmPose(self, depth_frame, armData):
        if armData is None:
            return
        self.armPose.header.frame_id = "Arm"
        self.armPose.header.stamp = rospy.Time.now()
        target = ["RWrist", "RElbow", "RShoulder", "LWrist", "LElbow", "LShoulder"]
        poses = [Pose() for _ in range(len(target))]
        for key, value in armData.items():
            rospy.loginfo(f"{key}: {value}")
            pose = Pose()
            points = self.calcWorldPose(depth_frame, value[0], value[1])
            if points is None:
                continue
            pose.position.x = points[0]
            pose.position.y = points[1]
            pose.position.z = points[2]
            pose.orientation = Quaternion(0, 0, 0, 1)
            if key in target:
                poses[target.index(key)] = pose
        self.armPose.poses = poses
        self.armPosePublisher.publish(self.armPose)

    def displayArmPose(self, color_image, armData):
        if armData is None:
            return
        for key, pose in armData.items():
            txt = key
            x, y = pose[0], pose[1]
            rospy.loginfo(f"{key}: {x}, {y}")
            print(x, y)
            cv2.circle(color_image, (x, y), 5, (0, 255, 0), -1)

            cv2.putText(
                color_image, txt, (x, y), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2
            )

    def armChecker(self, color_image, depth_frame):
        poseKeypoints = self.estimationHumanPose(color_image)
        armData = self.extractArmData(poseKeypoints)
        self.displayArmPose(color_image, armData)
        self.publishArmPose(depth_frame, armData)

        
    def mouseEvent(self, event, x, y, flags, param):
        angles = [15, 30, 45, 60, 75, 90, 105, 120, 135, 150]
        take_num = 5
        rospy.loginfo(f"take_cnt: {self.take_cnt}")
        id = self.take_cnt // (take_num * len(angles))
        if event == cv2.EVENT_LBUTTONDOWN:
            #　手の現在位置を記録
            color_image, depth_frame = self.getRSImages()
            result,_ = self.handDetertor.detect(color_image)
            while len(result.handedness) == 0:
                result , _= self.handDetertor.detect(color_image)
                rospy.loginfo(result)
            #手の中心座標を取得
            hand_average = [0, 0, 0]
            for landmark in result.hand_landmarks[0]:
                hand_average[0] += landmark.x * 640
                hand_average[1] += landmark.y * 480
                hand_average[2] += landmark.z
            hand_average = [int(x) // len(result.hand_landmarks[0]) for x in hand_average]
            hand_z = depth_frame.get_distance(hand_average[0], hand_average[1])
            hand_points = rs.rs2_deproject_pixel_to_point(
                self.color_intr, [hand_average[0], hand_average[1]], hand_z
            )
            cv2.circle(
                color_image,
                (hand_average[0], hand_average[1]),
                5,
                (255, 255, 255),
                -1,
            )
            rospy.loginfo(f"hand_points: {hand_points}")
            ntime = time.time()
            self.start_time = ntime
            self.hand_points = hand_points
        elif event == cv2.EVENT_RBUTTONDOWN:
            # 手の移動が終了
            finish_time = time.time()
            time_diff = finish_time - self.start_time
            rospy.loginfo(f"Time: {time_diff}")
            color_image, depth_frame = self.getRSImages()
            result,_ = self.handDetertor.detect(color_image)
            while len(result.handedness) == 0:
                result , _= self.handDetertor.detect(color_image)
            hand_average = [0, 0, 0]
            for landmark in result.hand_landmarks[0]:
                hand_average[0] += landmark.x * 640
                hand_average[1] += landmark.y * 480
                hand_average[2] += landmark.z
            hand_average = [int(x) // len(result.hand_landmarks[0]) for x in hand_average]
            hand_z = depth_frame.get_distance(hand_average[0], hand_average[1])
            hand_points = rs.rs2_deproject_pixel_to_point(
                self.color_intr, [hand_average[0], hand_average[1]], hand_z
            )
            rospy.loginfo(f"hand_points: {hand_points}")
            rospy.loginfo(f"hand_diff: {hand_points[0] - self.hand_points[0], hand_points[1] - self.hand_points[1], hand_points[2] - self.hand_points[2]}")
            rospy.loginfo(f"speed: {math.sqrt((hand_points[0] - self.hand_points[0])**2 + (hand_points[1] - self.hand_points[1])**2 + (hand_points[2] - self.hand_points[2])**2) / time_diff}")
def main():
    rospy.init_node("hand_image_taker")
    cv2.namedWindow("color_image", cv2.WINDOW_NORMAL)
    estimator = CVEstimator()
    rospy.loginfo("start")
    cv2.setMouseCallback("color_image", estimator.mouseEvent)
    while not rospy.is_shutdown():
        color_image, depth_frame = estimator.getRSImages()
        _,color_image = estimator.handDetertor.detect(color_image)
        image = cv_bridge.CvBridge().cv2_to_imgmsg(color_image, "bgr8")
        color_image = estimator.displayPipettePose(color_image)
        color_image = cv2.resize(color_image, (1280, 960))
        color_image = cv2.cvtColor(color_image,cv2.COLOR_RGB2BGR)
        cv2.imshow("color_image", color_image)
        cv2.waitKey(1)
    cv2.destroyAllWindows()
            
        
            
    


if __name__ == "__main__":
    main()
