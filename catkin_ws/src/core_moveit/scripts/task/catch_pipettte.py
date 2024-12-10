from ..operater import Operater
from ..cobotta.cobotta_arm import CobottaArmBcapInterface
from geometry_msgs.msg import PoseStamped
"""
1. ピペットにアームを十分に近づける
2. 適切にアームを回転させる
3. ピペットを把持する
"""
def catch_pipette(pos:PoseStamped,op:Operater,arm:CobottaArmBcapInterface):
    is_success = False
    while not is_success:
        is_success = op.mc_move_to(pos)
    """
    TODO:
    掴みやすいようになんかいい感じに回転
    """
    """
    arm.k3Hand.movej(0)
    arm.k3Hand.movej(1)
    arm.k3Hand.movej(2)
    """
def main():
    import rospy
    rospy.init_node('catch_pipette')
    op = Operater()
    arm = CobottaArmBcapInterface()
    pos = rospy.wait_for_message('object_pose',PoseStamped)
    catch_pipette(pos,op,arm)
    rospy.spin()
if __name__ == '__main__':
    main()