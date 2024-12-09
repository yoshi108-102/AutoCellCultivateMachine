#!/usr/bin/env python3
from geometry_msgs.msg import PoseStamped, PoseArray
from visualization_msgs.msg import MarkerArray
from sensor_msgs.msg import PointCloud2
import rospy

# moveit空間上に障害物を設定するクラス


class ObstacleSetter:
    def __init__(self):
        self.obstacle_pub = rospy.Publisher("obstacle", MarkerArray, queue_size=10)
        self.marker_sub = rospy.Subscriber()
