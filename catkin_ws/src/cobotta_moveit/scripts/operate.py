from cobotta_moveit.scripts.cobotta_ros import CobottaArm
from std_msgs.msg import Int32
import rospy


def main():
    cobotta = CobottaArm()

    rospy.init_node("cobotta_moveit")

    pub = rospy.Publisher("/cobotta/ChangeMode", Int32, queue_size=10)

    for _ in range(2):
        # start the normal mode
        pub.publish(0)
        rospy.sleep(1)

    # cobottaに接続
    cobotta.controller_connect()
    cobotta.controller_get_robot()
    cobotta.add_k3hand()

    cobotta.k3Hand.movej(1)

    # start the normal mode
    pub.publish(514)
    rospy.sleep(1)


if __name__ == "__main__":
    main()
