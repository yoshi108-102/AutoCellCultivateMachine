#!/usr/bin/env python
import rospy
from std_msgs.msg import String

def main():
    """
    ROSでは，プログラムを「ノード」という単位で管理します．
    ノードは，ROSの分散通信システムを利用して，データを送信したり受信したりします．
    """
    
    # ノードを登録します．この場合，ノードの名前は「tlab_handson」です．
    # anonymous=Trueを指定すると，ノードの名前が被らないように，後ろに乱数がつきます．
    rospy.init_node('tlab_handson', anonymous=True)
    
    rospy.loginfo("Hello ROS")

    while not rospy.is_shutdown():
        rospy.loginfo("Hello ROS") # Hello ROS というログを出力します
        rospy.sleep(1)        # 1秒間スリープします．

if __name__ == '__main__':
    main()
