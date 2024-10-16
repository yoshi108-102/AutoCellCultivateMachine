#!/usr/bin/env python3
import rospy
from std_srvs.srv import Empty

def clear_octomap(event):
    rospy.wait_for_service('/octomap_server/reset')
    try:
        clear_service = rospy.ServiceProxy('/octomap_server/reset', Empty)
        clear_service()
        rospy.loginfo("Octomap cleared")
    except rospy.ServiceException as e:
        rospy.logerr("Service call failed: %s" % e)
rospy.init_node('octomap_updater')
update_rate = rospy.get_param('~update_rate', 1)  # デフォルト60秒 
rospy.Timer(rospy.Duration(update_rate), clear_octomap)
rospy.spin()