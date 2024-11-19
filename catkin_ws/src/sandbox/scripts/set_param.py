#!/usr/bin/env python3
import rosparam

import rospy

rospy.init_node('/param')

# Set a parameter
rosparam.set_param('param', 'param')



