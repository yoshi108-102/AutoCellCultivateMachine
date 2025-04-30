import rospy
import random
from std_msgs.msg import Int32

def main():
    rospy.init_node('sum_publisher', anonymous=True)
    
    data = Int32(random.randint(0, 100))
    #-------kokokara-------
    
    #-------kokomade-------
    while not rospy.is_shutdown():
    #------kokokara-------
    
    #-------kokomade-------
        data.data = random.randint(0, 100)
        rospy.sleep(1)
if __name__ == '__main__':
    main()