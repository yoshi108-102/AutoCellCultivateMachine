import rospy
import random
from std_msgs.msg import Int32MultiArray

def main():
    rospy.init_node("hoge", anonymous=True)
    #こう書くと二つの数字を送信することができる
    #二つ目は割り算にも使うので0を入れないようにしている
    data = Int32MultiArray()
    data.data = [random.randint(0, 100), random.randint(1, 100)]
    #こう書くと，キーボードからの入力を受け取ることができる.
    #キーボードからなんらかの入力を受け取ると，その値がxに入る
    while not rospy.is_shutdown():
        x = input("Enter a number: ")
        