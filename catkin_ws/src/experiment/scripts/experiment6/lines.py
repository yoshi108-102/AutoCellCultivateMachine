#!/usr/bin/env python3
import cv2
import cv_bridge
import rospy
from sensor_msgs.msg import Image


def cb(msg):
    bridge = cv_bridge.CvBridge()
    cv_image = bridge.imgmsg_to_cv2(msg,"bgr8")
    line_vac = 160
    w,h = 640,480
    for i in range(w//line_vac):
        color = (0,255,0)
        cv2.line(cv_image,(i*line_vac,0),(i*line_vac,480),color,1)
    for i in range(h//line_vac):
        color = (0,255,0)
        cv2.line(cv_image,(0,i*line_vac),(w,i*line_vac),color,1)
    cv2.imshow("kousitenn",cv_image)
    cv2.waitKey(1)
def main():
    rospy.init_node("kousitenn")
    rospy.Subscriber("/camera/color/image_raw",Image,cb)
    rospy.spin()
if __name__ == "__main__":
    main()