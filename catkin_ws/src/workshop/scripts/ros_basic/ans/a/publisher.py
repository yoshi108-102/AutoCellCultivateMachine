import rospy
import random
from std_msgs.msg import Int32

def main():
    rospy.init_node('sum_publisher', anonymous=True)
    data = Int32(random.randint(0, 100))
    #-------kokokara-------
    pub = rospy.Publisher('sum_number', Int32, queue_size=10)
    #-------kokomade-------
    while not rospy.is_shutdown():
    #------kokokara-------
        pub.publish(data)
    #-------kokomade-------
        data.data = random.randint(0, 100)
        rospy.sleep(1)
if __name__ == '__main__':
    main()