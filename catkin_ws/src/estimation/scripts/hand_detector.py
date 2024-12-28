#!/usr/bin/env python3
import mediapipe as mp
from mediapipe.tasks import python
from mediapipe.tasks.python import vision
import cv2
import rospy
import roslib.packages
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
PKG_PATH = roslib.packages.get_pkg_dir("estimation")
# STEP 2: Create an HandLandmarker object.
class HandDetector:
    def __init__(self):
        self.base_options = python.BaseOptions(model_asset_path=PKG_PATH + "/data/hand_landmarker.task")
        self.options = vision.HandLandmarkerOptions(base_options=self.base_options,
                                                    min_tracking_confidence=0.7,
                                       num_hands=2)
        self.detector = vision.HandLandmarker.create_from_options(self.options)
        self.imgSubscriber = rospy.Subscriber("camera/color/image_raw", Image, self.callback)
    def callback(self, data):
        bridge = CvBridge()
        data = bridge.imgmsg_to_cv2(data, "bgr8")
        mediapipe_image = mp.Image(image_format=mp.ImageFormat.SRGB, data=data)
        results = self.detector.detect(mediapipe_image)
        rospy.loginfo(results)



if __name__ == "__main__":
    rospy.init_node("hand_detector", anonymous=True)
    hand_detector = HandDetector()
    rospy.spin()
