import rospy
from std_msgs.msg import Int32
def cb(data:Int32):
    #-------kokokara-------
    
    
    
    #-------kokomade-------
    rospy.loginfo("Received: %d", data.data)

def main():
    rospy.init_node('tashizan_subscriber', anonymous=True)
    
    #-------kokokara-------
    
    #-------kokomade-------
    rospy.spin()

if __name__ == '__main__':
    main()