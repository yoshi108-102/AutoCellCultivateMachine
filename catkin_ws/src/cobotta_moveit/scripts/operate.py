#!/usr/bin/env python3
import rospy
from cobotta_arm import CobottaArmBcapInterface
from cobotta_ros import CobottaArmMoveit
from constants import MODE
from std_msgs.msg import Int32, String


class CobottaOperator:
    def __init__(self):
        self.rCobotta = CobottaArmMoveit()
        self.rCobotta.changeMode(MODE.NORMAL)
        self.bCobotta = CobottaArmBcapInterface()
        self.bCobotta.controller_connect()
        self.bCobotta.add_k3hand()
        self.rCobotta.changeMode(MODE.SLAVE)
        self.taskSub = rospy.Subscriber("/cobotta/task", String, self.taskCallback)

    def taskCallback(self, msg: String):
        task_name = msg.data
        if task_name == "catch_pipette":
            self.catch_pipette()
        elif task_name == "pipetting":
            self.pipetting()
        else:
            rospy.logwarn("now this task is not supported")

    def catch_pipette(self):

        assert self.bCobotta.hControllerVt != -1
        assert self.bCobotta.hControllerValue != ""
        assert self.bCobotta.k3Hand.handleVt != -1
        assert self.bCobotta.k3Hand.handleValue != ""

        self.rCobotta.changeModePub.publish(MODE.NORMAL)
        rospy.loginfo("mode changed to normal")
        rospy.sleep(5)
        self.bCobotta.k3Hand.movej(0)
        rospy.sleep(0.5)
        self.bCobotta.k3Hand.movej(1)
        rospy.sleep(0.5)
        self.bCobotta.k3Hand.movej(2)
        rospy.sleep(0.5)
        self.bCobotta.k3Hand.movej(3)
        rospy.sleep(0.5)
        self.bCobotta.k3Hand.movej(4)
        rospy.sleep(0.5)
        self.bCobotta.k3Hand.movej(8)
        rospy.sleep(0.5)
        self.bCobotta.k3Hand.movej(7)
        rospy.sleep(0.5)
        for i in range(5):
            self.bCobotta.k3Hand.movej(6)
            rospy.sleep(0.5)
            self.bCobotta.k3Hand.movej(5)
            rospy.sleep(0.5)

        self.bCobotta.k3Hand.movej(0)

        self.bCobotta.free()
        exit()

    def pipetting(self):

        assert self.bCobotta.hControllerVt != -1
        assert self.bCobotta.hControllerValue != ""
        assert self.bCobotta.k3Hand.handleVt != -1
        assert self.bCobotta.k3Hand.handleValue != ""

        self.rCobotta.changeMode(MODE.NORMAL)

        self.bCobotta.k3Hand.movej(4)
        rospy.sleep(0.5)
        self.bCobotta.k3Hand.movej(8)
        rospy.sleep(0.5)
        self.bCobotta.k3Hand.movej(7)
        rospy.sleep(0.5)
        self.bCobotta.k3Hand.movej(6)


def main():
    rospy.init_node("cobotta_operator")

    cobotta_operator = CobottaOperator()
    rospy.loginfo("success")

    rospy.spin()


if __name__ == "__main__":
    main()
