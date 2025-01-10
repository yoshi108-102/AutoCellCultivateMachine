#!/usr/bin/env python3
import math
import os

import cv2
import mediapipe as mp
import numpy as np
import pyrealsense2 as rs
import roslib.packages
import rospy
from cv_bridge import CvBridge
from mediapipe import solutions
from mediapipe.framework.formats import landmark_pb2
from mediapipe.tasks import python
from mediapipe.tasks.python import vision
from sensor_msgs.msg import Image


def draw_landmarks_on_image(rgb_image, detection_result):
    pose_landmarks_list = detection_result.hand_landmarks
    annotated_image = np.copy(rgb_image)

    # Loop through the detected poses to visualize.
    for idx in range(len(pose_landmarks_list)):
        pose_landmarks = pose_landmarks_list[idx]

        # Draw the pose landmarks.
        pose_landmarks_proto = landmark_pb2.NormalizedLandmarkList()
        pose_landmarks_proto.landmark.extend(
            [
                landmark_pb2.NormalizedLandmark(
                    x=landmark.x, y=landmark.y, z=landmark.z
                )
                for landmark in pose_landmarks
            ]
        )
        solutions.drawing_utils.draw_landmarks(
            annotated_image,
            pose_landmarks_proto,
        )
    return annotated_image


PKG_PATH = roslib.packages.get_pkg_dir("estimation")
PKG_PATH2 = roslib.packages.get_pkg_dir("experiment")

# STEP 2: Create an HandLandmarker object.
class HandDetector:
    def __init__(self):
        self.base_options = python.BaseOptions(
            model_asset_path=PKG_PATH + "/data/hand_landmarker.task"
        )
        self.options = vision.HandLandmarkerOptions(
            base_options=self.base_options, min_tracking_confidence=0.6, num_hands=2
        )
        self.detector = vision.HandLandmarker.create_from_options(self.options)

    def detect(self, cv_image: cv2.VideoCapture):
        cv_image = cv2.cvtColor(cv_image, cv2.COLOR_BGR2RGB)
        mediapipe_image = mp.Image(image_format=mp.ImageFormat.SRGB, data=cv_image)
        results = self.detector.detect(mediapipe_image)
        hand_average = [0, 0, 0]
        try:
            for landmark in results.hand_landmarks[0]:
                hand_average[0] += landmark.x * 640
                hand_average[1] += landmark.y * 480
                hand_average[2] += landmark.z
            hand_average = [int(x) // len(results.hand_landmarks[0]) for x in hand_average]
            cv2.circle(
            cv_image,
            (hand_average[0], hand_average[1]),
            5,
            (255, 255, 255),
            -1,
        )
        except Exception as e:
            pass
        return results,cv_image

    def make_hand_contor(self, img, depth_frame, color_intr,length,id,angle_id):
        hand_average = [0, 0, 0]
        #cv2.imshow("hand2", img)
        results,_ = self.detect(img)
        if len(results.hand_landmarks) == 0:
            # 画像が保存されている場合は削除
            file_path = os.path.join(PKG_PATH2, "dataset", "experiment4", "real_hand",str(id),str(angle_id))
            os.remove(os.path.join(file_path, str(length) + ".jpg"))
            return False
        for landmark in results.hand_landmarks[0]:
            hand_average[0] += landmark.x * 640
            hand_average[1] += landmark.y * 480
            hand_average[2] += landmark.z
        hand_average = [int(x) // len(results.hand_landmarks[0]) for x in hand_average]
        hand_z = depth_frame.get_distance(hand_average[0], hand_average[1])
        hand_points = rs.rs2_deproject_pixel_to_point(
            color_intr, [hand_average[0], hand_average[1]], hand_z
        )
        # 円の半径(mm)
        wrist = results.hand_landmarks[0][0]
        p_radius = int(math.sqrt((hand_average[0] - wrist.x * 640) ** 2 + (hand_average[1] - wrist.y * 480) ** 2) * 2 // 3)
        rospy.loginfo(f"hand_points: {hand_points}")
        result_image = np.zeros((480, 640, 3), np.uint8)
        # 塗りつぶした円
        cv2.circle(
            result_image,
            (hand_average[0], hand_average[1]),
            p_radius,
            (255, 255, 255),
            -1,
        )

        # 矩形を作成
       
        diffs = [(wrist.x - hand_average[0] / 640) * 640, (wrist.y - hand_average[1] / 480) * 480]
        diffs = [int(x) * 4 for x in diffs]
        rospy.loginfo(f"diffs: {diffs}")
        rospy.loginfo(f"radius: {p_radius}")
        normal_vec = [
            -diffs[1] / math.sqrt(diffs[0] ** 2 + diffs[1] ** 2),
            diffs[0] / math.sqrt(diffs[0] ** 2 + diffs[1] ** 2),
        ]
        rospy.loginfo(f"normal_vec: {normal_vec}")
        p_radius = p_radius * 5 // 6
        left_up = [
            wrist.x * 640 + normal_vec[0] * p_radius,
            wrist.y * 480 + normal_vec[1] * p_radius,
        ]
        left_down = [
            wrist.x * 640 - normal_vec[0] * p_radius,
            wrist.y * 480 - normal_vec[1] * p_radius,
        ]
        right_down = [
            wrist.x * 640 + diffs[0] - normal_vec[0] * p_radius,
            wrist.y * 480 + diffs[1] - normal_vec[1] * p_radius,
        ]
        rigit_up = [
            wrist.x * 640 + diffs[0] + normal_vec[0] * p_radius,
            wrist.y * 480 + diffs[1] + normal_vec[1] * p_radius,
        ]
        rospy.loginfo(f"left_up, left_down, right_down, rigit_up: {left_up, left_down, right_down, rigit_up}")
        cv2.fillPoly(
            result_image,
            np.array(
                [
                    [left_up, left_down, right_down, rigit_up]
                ],
                np.int32,
            ),
            (255, 255, 255),
        )
        file_path = os.path.join(PKG_PATH2, "dataset", "experiment4", "detect_hand",str(id),str(angle_id))
        if not os.path.exists(file_path):
            os.makedirs(file_path)
        length = len(os.listdir(file_path))
        cv2.imwrite(os.path.join(file_path, str(length) + ".jpg"), result_image)
        return True
        

    def cb(self, msg):
        bridge = CvBridge()
        cv_img = bridge.imgmsg_to_cv2(msg, "bgr8")
        self.detect(cv_img)


if __name__ == "__main__":
    rospy.init_node("hand_detector", anonymous=True)
    hand_detector = HandDetector()
    rospy.Subscriber("/camera/color/image_raw", Image, hand_detector.cb)
    rospy.spin()
