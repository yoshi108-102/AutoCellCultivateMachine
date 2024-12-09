import rospy 
from trajectory_msgs.msg import JointTrajectory
from geometry_msgs.msg import PoseStamped
import moveit_commander
import tf2_ros
import tf2_geometry_msgs
class Operater:
    def __init__(self):
        self.buffer = tf2_ros.Buffer()
        self.listener = tf2_ros.TransformListener(self.buffer)
        self.mc_group = moveit_commander.MoveGroupCommander("arm_group")
        self.cob_group = moveit_commander.MoveGroupCommander("arm")
        self.mc_joint_pub = rospy.Publisher('mycobot_arm_controller/follow_joint_trajectory',
                                            JointTrajectory, queue_size=1)
        self.cob_joint_pub = rospy.Publisher('arm_controller/follow_joint_trajectory',
                                             JointTrajectory, queue_size=1)
        self.mc_joints=[
            'mycobot_arm_joint_0',
            'mycobot_arm_joint_1',
            'mycobot_arm_joint_2',
            'mycobot_arm_joint_3',
            'mycobot_arm_joint_4',
            'mycobot_arm_joint_5'
        ]
        self.cob_joints=[
            'joint_1',
            'joint_2',
            'joint_3',
            'joint_4',
            'joint_5',
            'joint_6'
        ]
    def is_new_topic(target):
        if rospy.Time.now() - target.header.stamp > rospy.Duration(0.1):
            return False
        return True
    def mc_move_to(self,target:PoseStamped):
        if not self.is_new_topic(target):
            return
        try:
            trans = self.buffer.lookup_transform(target_frame="mycobot_base_link",
                                                    source_frame=target.header.frame_id,
                                                    time=target.header.stamp)                                    
        except Exception as e:
            rospy.logwarn(e)
            return
        pos = tf2_geometry_msgs.do_transform_point(target.pose.position,trans)
        
        self.mc_group.set_position_target([pos.x,pos.y,pos.z])
        self.mc_group.go()
    def cob_move_to(self,target:PoseStamped):
        if not self.is_new_topic(target):
            return
        try:
            trans = self.buffer.lookup_transform(target_frame="base_link",
                                                    source_frame=target.header.frame_id,
                                                    time=target.header.stamp)                                    
        except Exception as e:
            rospy.logwarn(e)
            return
        pos = tf2_geometry_msgs.do_transform_point(target.pose.position,trans)
        
        self.mc_group.set_position_target([pos.x,pos.y,pos.z])
        self.mc_group.go()

def main():
    rospy.init_node('operater')
    operater = Operater()
    rospy.spin()