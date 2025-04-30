import rospy
import random
from std_msgs.msg import Int32MultiArray

def main():
    rospy.init_node("num_data_node", anonymous=True)
    #こう書くと二つの数字を送信することができる
    #二つ目は割り算にも使うので0を入れないようにしている
    data = Int32MultiArray()
    data.data = [random.randint(0, 100), random.randint(1, 100)]
    pub = rospy.Publisher("num_data_topic", Int32MultiArray, queue_size=10)
    while not rospy.is_shutdown():
        pub.publish(data)
        data.data[0] = random.randint(0, 100)
        data.data[1] = random.randint(1, 100)
        rospy.sleep(1)

if __name__ == "__main__":
    main()