#!/usr/bin/env python3
import os

import cv2
import cv_bridge
import numpy as np
import pyrealsense2 as rs
import roslib.packages
import rospy
from geometry_msgs.msg import Pose, PoseArray, PoseStamped
from openpose import pyopenpose as op
from screeninfo import get_monitors
from sensor_msgs.msg import Image
from ultralytics import YOLO
from visualization_msgs.msg import MarkerArray

pkg_path = roslib.packages.get_pkg_dir("mycobot_320_moveit")

HOME_DIR = os.path.expanduser("~")

class CVEstimator:
    def __init__(self):
        self.openpose_init()
        self.camera_init()
        self.yolo_init()
        self.pipettePose = PoseStamped()
        self.armPose = PoseArray()
        self.pipettePosePublisher = rospy.Publisher(
            "target_estimation", PoseStamped, queue_size=10
        )
        self.armPosePublisher = rospy.Publisher(
            "arm_estimation", PoseArray, queue_size=10
        )
        self.imageRawPublisher = rospy.Publisher(
            "camera/color/image_raw", Image, queue_size=10
        )

    def yolo_init(self):
        self.pipetteModel = YOLO(
            HOME_DIR + "/yolo_dataset/runs/detect/train/weights/best.pt"
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
        txt = "PipetteHead"
        x, y, z = (
            self.pipettePose.pose.position.x,
            self.pipettePose.pose.position.y,
            self.pipettePose.pose.position.z,
        )
        x, y, z = map(lambda w: str(round(w, 3)), [x, y, z])
        cv2.putText(
            color_image, txt, (0, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2
        )
        txt = "X [m]: " + x
        cv2.putText(
            color_image, txt, (0, 80), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2
        )
        txt = "Y [m]: " + y
        cv2.putText(
            color_image, txt, (0, 110), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2
        )
        txt = "Z [m]: " + z
        cv2.putText(
            color_image, txt, (0, 140), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2
        )

    # pipetteを検出し、位置を推定するe
    def pipetteChecker(self, color_image, depth_frame):
        x, y = self.estimatePipettePose(color_image)
        points = self.calcWorldPose(depth_frame, x, y)
        self.publishPipettePose(depth_frame, points)
        self.displayPipettePose(color_image)

    def estimationHumanPose(self, color_image):
        self.datum = op.Datum()
        self.datum.cvInputData = color_image
        self.opWrapper.emplaceAndPop(op.VectorDatum([self.datum]))
        return self.datum.poseKeypoints

    # 手首、肘、肩の位置情報だけ抽出する
    # とりあえず右手だけ
    def extractArmData(self, poseKeypoints, conf=0.2):
        if poseKeypoints is None:
            return None
        armData = dict()
        target = ["RWrist", "RElbow", "RShoulder"]
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
        self.armPose.poses = []
        for _, value in armData.items():
            pose = Pose()
            points = self.calcWorldPose(depth_frame, value[0], value[1])
            if points is None:
                continue
            pose.position.x = points[0]
            pose.position.y = points[1]
            pose.position.z = points[2]
            pose.orientation.x = 0
            pose.orientation.y = 0
            pose.orientation.z = 0
            pose.orientation.w = 1.0
            print(pose)
            self.armPose.poses.append(pose)
        self.armPosePublisher.publish(self.armPose)

    def displayArmPose(self, color_image):
        for pose in self.armPose.poses:
            # poseの座標を画像上の座標に変換
            x, y = rs.rs2_project_point_to_pixel(
                self.color_intr, [pose.position.x, pose.position.y, pose.position.z]
            )
            x, y = int(x), int(y)
            cv2.circle(color_image, (x, y), 5, (0, 255, 0), -1)
            txt = "Arm"
            cv2.putText(
                color_image, txt, (x, y), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2
            )

    def armChecker(self, color_image, depth_frame):
        poseKeypoints = self.estimationHumanPose(color_image)
        armData = self.extractArmData(poseKeypoints)
        self.publishArmPose(depth_frame, armData)
        self.displayArmPose(color_image)


def main():
    rospy.init_node("target_estimation", anonymous=True)
    estimator = CVEstimator()
    while not rospy.is_shutdown():
        color_image, depth_frame = estimator.getRSImages()
        image = cv_bridge.CvBridge().cv2_to_imgmsg(color_image, "bgr8")
        estimator.imageRawPublisher.publish(image)
        try:
            estimator.pipetteChecker(color_image, depth_frame)
        except Exception as e:
            rospy.logwarn(e)
        cv2.imshow("color", color_image)
        cv2.waitKey(1)


if __name__ == "__main__":
    main()
