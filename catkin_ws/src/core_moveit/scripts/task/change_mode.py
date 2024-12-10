import rospy

from std_msgs.msg import Int32

def changeMode(mode:int):
    changeModePub = rospy.Publisher(
        'ChangeMode', Int32,queue_size=10
    )
    while True:
        changeModePub.publish(Int32(mode))
        try:
            now_mode = rospy.wait_for_message('CurMode',Int32,timeout=0.1)
            if now_mode.data==mode:
                break
        except:
            pass
    rospy.sleep(1)
        