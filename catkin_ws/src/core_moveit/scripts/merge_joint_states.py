#!/usr/bin/env python3

import rospy
import numpy as np
from sensor_msgs.msg import JointState


class JointStatesMerger:
    def __init__(self):
        self.joint_state_1 = None
        self.joint_state_2 = JointState()
        self.joint_state_2.position = [- np.pi / 2.0, 0, 0, 0]
        self.joint_state_2.name = [
            'rhand_thumb_base_joint',
            'rhand_thumb_joint',
            'rhand_index_base_joint',
            'rhand_index_joint',
        ]
        self.joint_state_3 = JointState()
        self.joint_state_3.position = [- np.pi / 2.0, 0, 0, 0]
        self.joint_state_3.name = [
            'lhand_thumb_base_joint',
            'lhand_thumb_joint',
            'lhand_index_base_joint',
            'lhand_index_joint',
        ]

        self.joint_states_pub = rospy.Publisher('/concat_joint_states',
                                                JointState, queue_size=1)
        self.joint_state_1_sub = rospy.Subscriber('/joint_states',
                                                  JointState, self.joint_state_1_callback,
                                                  queue_size=1)
        self.joint_state_2_sub = rospy.Subscriber('/rhand/joint_states',
                                                  JointState, self.joint_state_2_callback,
                                                  queue_size=1)
        self.joint_state_3_sub = rospy.Subscriber('/lhand/joint_states',
                                                  JointState, self.joint_state_3_callback,
                                                  queue_size=1)

    def joint_state_1_callback(self, msg):
        self.joint_state_1 = msg
        self.publish_merged_joint_states()

    def joint_state_2_callback(self, msg):
        self.joint_state_2 = msg

    def joint_state_3_callback(self, msg):
        self.joint_state_3 = msg

    def publish_merged_joint_states(self):
        if self.joint_state_1 is None or self.joint_state_2 is None or self.joint_state_3 is None:
            return

        merged_joint_state = JointState()
        merged_joint_state.header.stamp = rospy.Time.now()
        merged_joint_state.name = self.joint_state_1.name + self.joint_state_2.name + self.joint_state_3.name
        merged_joint_state.position = list(self.joint_state_1.position) + list(self.joint_state_2.position) + list(self.joint_state_3.position)
        merged_joint_state.velocity = list(self.joint_state_1.velocity) + list(self.joint_state_2.velocity) + list(self.joint_state_3.velocity)
        merged_joint_state.effort = list(self.joint_state_1.effort) + list(self.joint_state_2.effort) + list(self.joint_state_3.effort)
        self.joint_states_pub.publish(merged_joint_state)


if __name__ == '__main__':
    rospy.init_node('joint_states_merger')
    merger = JointStatesMerger()
    rospy.spin()