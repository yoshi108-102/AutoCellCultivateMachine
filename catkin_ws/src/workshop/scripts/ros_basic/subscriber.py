import rospy
from std_msgs.msg import String

def cb(data):
    """
    cbは callback の略です
    
    """
    rospy.loginfo(data)
def main():
    """
    他のプログラムが送信したデータを受信することを「サブスクライブ」といいます。
    サブスクライブには，
    1. どのデータを受信するか -> データを送信しているトピック名
    2. どんなデータを受信するか（文字列か，数値か，はたまた画像か）-> データの型
    3. 受信したデータをどのように処理するか -> コールバック関数(cb)
    を指定する必要があります．
    """
    rospy.init_node('subscriber', anonymous=True)
    rospy.Subscriber("tlab_topic", String, cb)
    rospy.spin()

if __name__ == '__main__':
    main()
