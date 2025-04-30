import rospy
from std_msgs.msg import String

def main():
    rospy.init_node("operator_node", anonymous=True)
    pub = rospy.Publisher("operator_topic", String, queue_size=10)
    
    while not rospy.is_shutdown():
        data = input("Enter an operator (+, -, *, /, %): ")
        pub.publish(String(data))
    
if __name__ == "__main__":
    main()