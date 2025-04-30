import rospy
from std_msgs.msg import String

def main():
    """
    他のプログラムにデータを送信することを「パブリッシュ」といいます。
    """
    rospy.init_node('publisher', anonymous=True)
    """
    データを送信するためのPublisherを作成します．
    ROSでは，送信されたデータのことを「トピック」と呼びます．
    データを受信する側は，トピック名を指定することでデータを取得することになります．
    送信時には，
    1. データを送信するトピック名
    2. どんなデータを送信するか（文字列か，数値か，はたまた画像か）-> データの型
    3. 送信するデータのキューサイズ -> 今は無視して良い
    を指定する必要があります．
    """
    pub = rospy.Publisher("tlab_topic", String, queue_size=10)
    #同じプログラムから複数のデータを送信することもできます．
    pub2 = rospy.Publisher("tlab_topic2", String, queue_size=10)
    while not rospy.is_shutdown():
        hello_str = "hello world %s" % rospy.get_time()
        pub.publish(hello_str)
        pub2.publish(hello_str)
        rospy.loginfo("data published")
        rospy.sleep(1) 

if __name__ == "__main__":
    main() 
