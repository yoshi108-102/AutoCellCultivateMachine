#!/usr/bin/env python3
import rospy
from geometry_msgs.msg import PoseStamped
def pipette_marker() -> PoseStamped:
    pose = PoseStamped()
    pose.header.frame_id = "PipetteHead"
    pose.pose.position.x = 0.0
    pose.pose.position.y = -0.1
    pose.pose.position.z = 0.2
    
    pose.header.stamp = rospy.Time.now()
    return pose
def main():
    rospy.init_node("target_estimation", anonymous=True)
    pub = rospy.Publisher("target_estimation", PoseStamped, queue_size=10)
    while not rospy.is_shutdown():
        pub.publish(pipette_marker())
if __name__ == "__main__":
    main()
    