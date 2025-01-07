#!/usr/bin/env python3
import cv2
import mediapipe as mp
import numpy as np
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
    pose_landmarks_proto.landmark.extend([
      landmark_pb2.NormalizedLandmark(x=landmark.x, y=landmark.y, z=landmark.z) for landmark in pose_landmarks
    ])
    solutions.drawing_utils.draw_landmarks(
      annotated_image,
      pose_landmarks_proto,
    )
  return annotated_image
PKG_PATH = roslib.packages.get_pkg_dir("estimation")
# STEP 2: Create an HandLandmarker object.
class HandDetector:
    def __init__(self):
        self.base_options = python.BaseOptions(model_asset_path=PKG_PATH + "/data/hand_landmarker.task")
        self.options = vision.HandLandmarkerOptions(base_options=self.base_options,
                                                    min_tracking_confidence=0.6,
                                       num_hands=2)
        self.detector = vision.HandLandmarker.create_from_options(self.options)
    def detect(self,cv_image: cv2.VideoCapture):
        cv_image = cv2.cvtColor(cv_image, cv2.COLOR_BGR2RGB)
        mediapipe_image = mp.Image(image_format=mp.ImageFormat.SRGB, data=cv_image)
        results = self.detector.detect(mediapipe_image)
        self.make_hand_contor(cv_image,results)
        annotated = draw_landmarks_on_image(mediapipe_image.numpy_view(), results)
        annotated = cv2.cvtColor(annotated, cv2.COLOR_RGB2BGR)
       
        return results
    def make_hand_contor(self,img,results,depth_frame):
        hand_average = [0,0,0]
        print(results)
        for landmark in results.hand_landmarks[0]:
            hand_average[0] += landmark.x *640   
            hand_average[1] += landmark.y * 480
            hand_average[2] += landmark.z   
        hand_average = [int(x) // len(results.hand_landmarks[0]) for x in hand_average]
        cv2.circle(img,(hand_average[0],hand_average[1]),radius = 50,color=(0,255,0))
        img = cv2.cvtColor(img,cv2.COLOR_BGR2RGB)
        cv2.imwrite("./image.png",img)
    def cb(self,msg):
        bridge = CvBridge()
        cv_img = bridge.imgmsg_to_cv2(msg,"bgr8")
        self.detect(cv_img)


if __name__ == "__main__":
    rospy.init_node("hand_detector", anonymous=True)
    hand_detector = HandDetector()
    rospy.Subscriber("/camera/color/image_raw",Image,hand_detector.cb)
    rospy.spin()
