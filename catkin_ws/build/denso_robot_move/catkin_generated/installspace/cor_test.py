# V2 Gripper
from __future__ import print_function
from site import getusersitepackages

import time
import sys
import rospy
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg

from std_msgs.msg import Float32
from sensor_msgs.msg import JointState
from geometry_msgs.msg import Pose, Point32
from gripper_ntlab_msgs.msg import CartesianPosition
from math import pi, tau, dist, fabs, cos
from moveit_commander.conversions import pose_to_list
from tf.transformations import euler_from_quaternion, quaternion_from_euler

# Enter F_total
F_total = 1.59

# generate pressure from Force----------------------------------
pressure_each_finger = F_total*(4/1.96)/2 #F_total x (pressure to force param)/number of finger

# define parameter ---------------------------------------------
USE_COBOTTA = True
WITH_COR = True         # center of rotation adjustment
AUTO_ = True            # make the sequence run automatically, used in end_func()
sleep_time = 1.0        # sleep for AUTO_

length = [0.1453, 0.09945, 0.06687, 0.06171, 0.05203, 0.05, 0.04248, 0.05203]
weight = [0.023, 0.011, 0.008, 0.007, 0.004, 0.003, 0.002, 0.003]

object_num = 1

# Set as the actual object
object_length = length[object_num - 1]  # in meter
object_weight = weight[object_num - 1]  # in kg

hand_offset_z = 0.030  # in meter
limit_torque = 2 * object_weight + 0.027  # offset linear function
# Set Input
#pick_position = [0.068209, 0.236942, 0.331653]
pick_position = [0.019115, 0.162730, 0.348901, -0.999982, -0.000438, 0.002414, 0.005420]
place_position = [0.019115, 0.162730, 0.348901, -0.999982, -0.000438, 0.002414, 0.005420]
standby_pos = [0.244, -0.065, 0.244, 0.065, 0]

################################################################

def all_close(goal, actual, tolerance):
    """
    Convenience method for testing if the values in two lists are within a tolerance of each other.
    For Pose and PoseStamped inputs, the angle between the two quaternions is compared (the angle
    between the identical orientations q and -q is calculated correctly).
    @param: goal       A list of floats, a Pose or a PoseStamped
    @param: actual     A list of floats, a Pose or a PoseStamped
    @param: tolerance  A float
    @returns: bool
    """
    if type(goal) is list:
        for index in range(len(goal)):
            if abs(actual[index] - goal[index]) > tolerance:
                return False

    elif type(goal) is geometry_msgs.msg.PoseStamped:
        return all_close(goal.pose, actual.pose, tolerance)

    elif type(goal) is geometry_msgs.msg.Pose:
        x0, y0, z0, qx0, qy0, qz0, qw0 = pose_to_list(actual)
        x1, y1, z1, qx1, qy1, qz1, qw1 = pose_to_list(goal)
        # Euclidean distance
        d = dist((x1, y1, z1), (x0, y0, z0))
        # phi = angle between orientations
        cos_phi_half = fabs(qx0 * qx1 + qy0 * qy1 + qz0 * qz1 + qw0 * qw1)
        return d <= tolerance and cos_phi_half >= cos(tolerance / 2.0)
    elif type(goal) is CartesianPosition:
        ax1, ay1, ax2, ay2, arad = to_list(actual)
        gx1, gy1, gx2, gy2, grad = to_list(goal)
        d1 = dist((ax1, ay1), (gx1, gy1))
        d2 = dist((ax2, ay2), (gx2, gy2))
        dist_angle = fabs(arad - grad)
        return d1 <= tolerance and d2 <= tolerance and dist_angle <= tolerance
    else:
        if abs(actual - goal) > tolerance:
                return False
    return True


class GripperNTLab(object):

    gripper_pose = CartesianPosition()
    current_gripper_pose = CartesianPosition()
    cop_left = Point32()
    cop_right = Point32()
    pressure_left = 0.0
    pressure_right = 0.0
    init_finished = False

    def __init__(self, use_cobotta) -> None:
        """
        use_cobotta: (True/False) Use Cobotta as a real manipulator robot or just skip it to only move the gripper.
        """
        # Initialization -----
        super(GripperNTLab, self).__init__()
        moveit_commander.roscpp_initialize(sys.argv)
        rospy.init_node("move_interface", anonymous=True)

        # Publisher ----
        gripper_pub = rospy.Publisher(
            "cobotta/hand_set_cartesian", CartesianPosition, queue_size=10
        )

        cop_left_hand_pub = rospy.Publisher(
            "/cop_left_hand", Point32, queue_size=10
        )

        cop_right_hand_pub = rospy.Publisher(
            "/cop_right_hand", Point32, queue_size=10
        )

        # Subscriber ----
        rospy.Subscriber(
            "/cop_left", Point32, self.cop_left_callback
        )

        rospy.Subscriber(
            "/cop_right", Point32, self.cop_right_callback
        )

        rospy.Subscriber(
            "/pressure_left", Float32, self.pressure_left_callback
        )

        rospy.Subscriber(
            "/pressure_right", Float32, self.pressure_right_callback
        )
        
        rospy.Subscriber(
            "cobotta/all_joint_states", JointState, self.joint_state_callback
        )
        rospy.Subscriber(
            "gripper_ntlab/cartesian_position",
            CartesianPosition,
            self.gripper_cartesian_position_callback,
        )

        robot = moveit_commander.RobotCommander() if use_cobotta else None
        scene = moveit_commander.PlanningSceneInterface() if use_cobotta else None

        group_name = "arm"
        move_group = (
            moveit_commander.MoveGroupCommander(group_name) if use_cobotta else None
        )

        # set initial parameter for manipulator robot
        if use_cobotta:
            move_group.set_max_velocity_scaling_factor(0.9)
            move_group.set_max_acceleration_scaling_factor(0.9)

        display_trajectory_publisher = rospy.Publisher(
            "/move_group/display_planned_path",
            moveit_msgs.msg.DisplayTrajectory,
            queue_size=20,
        )

        print("============ Use Cobotta: %s" % use_cobotta)

        planning_frame = move_group.get_planning_frame() if use_cobotta else None
        print("============ Planning frame: %s" % planning_frame)

        # We can also print the name of the end-effector link for this group:
        eef_link = move_group.get_end_effector_link() if use_cobotta else None
        print("============ End effector link: %s" % eef_link)

        # We can get a list of all the groups in the robot:
        group_names = robot.get_group_names() if use_cobotta else None
        print("============ Available Planning Groups:", group_names)

        # Sometimes for debugging it is useful to print the entire state of the
        # robot:
        robot_current_state = robot.get_current_state() if use_cobotta else None
        print("============ Printing robot state")
        print(robot_current_state)
        print("")

        self.box_name = ""
        self.robot = robot
        self.scene = scene
        self.move_group = move_group
        self.use_cobotta = use_cobotta
        self.display_trajectory_publisher = display_trajectory_publisher
        self.planning_frame = planning_frame
        self.eef_link = eef_link
        self.group_names = group_names
        self.gripper_pub = gripper_pub
        self.cop_left_hand_pub =cop_left_hand_pub
        self.cop_right_hand_pub =cop_right_hand_pub
        self.finger_torque = [0, 0]

    def cobotta_execute_pose_goal(self, position, wait):
        if self.use_cobotta:
            move_group = self.move_group

            pose_goal = list_to_pose(position)

            move_group.set_pose_target(pose_goal)

            # call planner to execute
            move_group.go(wait=wait)
            # Calling `stop()` ensures that there is no residual movement
            move_group.stop()
            # It is always good to clear your targets after planning with poses.
            # Note: there is no equivalent function for clear_joint_value_targets()
            move_group.clear_pose_targets()

            current_pose = self.move_group.get_current_pose().pose
            return all_close(pose_goal, current_pose, 0.01)
        else:
            return True

    def cobotta_wait_execution(self, position, timeout):  # timeout in (s)
        if self.use_cobotta:
            start = time.time()
            ret = False
            while time.time() < start + timeout and not ret:
                current_pose = self.move_group.get_current_pose().pose
                ret = all_close(position, current_pose, 0.003)
                rospy.sleep(0.01)
            return ret
        else:
            return True

    def gripper_execute_and_wait(self, timeout):  # timeout in (s)
        start = time.time()
        ret = False
        while time.time() < start + timeout and not ret:
            self.gripper_execute()
            current_pose = self.current_gripper_pose
            ret = all_close(self.gripper_pose, current_pose, 0.01)
            rospy.sleep(0.2)
        return ret

    def pressure_left_callback(self, data):
        self.pressure_left = data.data

    def pressure_right_callback(self, data):
        self.pressure_right = data.data

    def cop_left_callback(self, data):
        self.cop_left.x = data.x
        self.cop_left.y = data.y - (self.current_gripper_pose.x1 - standby_pos[0]) * 1000
        self.cop_left.z = data.z
        if self.init_finished:
            self.cop_left_hand_pub.publish(self.cop_left)

    def cop_right_callback(self, data):
        self.cop_right.x = data.x
        self.cop_right.y = data.y - (self.current_gripper_pose.x2 - standby_pos[2]) * 1000
        self.cop_right.z = data.z
        if self.init_finished:
            self.cop_right_hand_pub.publish(self.cop_right)

    def joint_state_callback(self, data):
        i = 0
        f1, f2 = (0, 0)
        for t in data.name:
            if t == "l_hand_rod_a":
                f1 = data.effort[i]
            elif t == "r_hand_rod_b":
                f2 = data.effort[i]
            i += 1
        # rospy.loginfo("f1:{}, f2:{}".format(f1, f2))
        self.finger_torque = [f1, f2]

    # x1, y1, theta1, x2, y2, theta2
    def gripper_cartesian_position_callback(self, data):
        self.current_gripper_pose.x1 = data.x1
        self.current_gripper_pose.y1 = data.y1
        self.current_gripper_pose.x2 = data.x2
        self.current_gripper_pose.y2 = data.y2
        self.current_gripper_pose.rad = data.rad
        # print("gripper_cartesian_position_callback: %s" % self.current_gripper_pose)

    def gripper_set_pose(self, position, buffer):
        self.gripper_pose.x1 = position[0]
        self.gripper_pose.y1 = position[1]
        self.gripper_pose.x2 = position[2]
        self.gripper_pose.y2 = position[3]
        self.gripper_pose.rad = position[4]
        self.gripper_pose.buffer = buffer
        self.gripper_pose.torque = True

    def gripper_execute(self):
        gripper_pub = self.gripper_pub
        gripper_pub.publish(self.gripper_pose)

    def gripper_grip_limit_torque(self):
        gripper_position = to_list(self.current_gripper_pose)
        # print("f1:" + str(self.finger_torque[0]) + ", f2:" + str(self.finger_torque[1]))
        while (
            self.finger_torque[0] <= limit_torque
            and self.finger_torque[0] >= -limit_torque
            and self.finger_torque[1] <= limit_torque
            and self.finger_torque[1] >= -limit_torque
        ):
            print(str(self.pressure_left) + " " + str(self.pressure_right))
            gripper_position[1] += 0.0001
            gripper_position[3] -= 0.0001
            self.gripper_set_pose(gripper_position, 0)
            self.gripper_execute()
            # print(
            #     "res f1:"
            #     + str(self.finger_torque[0])
            #     + ", f2:"
            #     + str(self.finger_torque[1])
            # )
            rospy.sleep(0.01)
    
    def gripper_grip_limit_pressure(self):
        gripper_position = to_list(self.current_gripper_pose)
        # print("f1:" + str(self.finger_torque[0]) + ", f2:" + str(self.finger_torque[1]))
        limit_pressure = pressure_each_finger

        while (
            self.pressure_left <= limit_pressure
            and self.pressure_right <= limit_pressure
        ):
            gripper_position[1] += 0.0001
            gripper_position[3] -= 0.0001
            self.gripper_set_pose(gripper_position, 0)
            self.gripper_execute()
            # print(
            #     "res f1:"
            #     + str(self.finger_torque[0])
            #     + ", f2:"
            #     + str(self.finger_torque[1])
            # )
            rospy.sleep(0.01)

    def gripper_move_up_and_down(self, offset):
        gripper_position = to_list(self.current_gripper_pose)
        direction = True
        i = 0
        i_max = 1
        limit_min = gripper_position[0] - offset
        limit_max = gripper_position[0] + offset
        while i < i_max:
            if direction:
                while gripper_position[0] > limit_min:
                    gripper_position[0] -= 0.0001
                    gripper_position[2] += 0.0001
                    self.gripper_set_pose(gripper_position, 0)
                    self.gripper_execute()
                    rospy.sleep(0.01)
                direction = False
            else:
                while gripper_position[0] < limit_max:
                    gripper_position[0] += 0.0001
                    gripper_position[2] -= 0.0001
                    self.gripper_set_pose(gripper_position, 0)
                    self.gripper_execute()
                    rospy.sleep(0.01)
                direction = True
            i += 1

    def gripper_release(self, offset):
        gripper_position = to_list(self.current_gripper_pose)
        limit_position = gripper_position[3] + offset
        while gripper_position[3] <= limit_position:
            gripper_position[1] -= 0.0001
            gripper_position[3] += 0.0001
            self.gripper_set_pose(gripper_position, 0)
            self.gripper_execute()
            rospy.sleep(0.01)

    # Get current pose of Cobotta
    def get_current_pose(self):
        if self.use_cobotta:
            return self.move_group.get_current_pose().pose
        else:
            return Pose()


def to_list(param):
    if type(param) == type(CartesianPosition()):
        ret = []
        ret.append(param.x1)
        ret.append(param.y1)
        ret.append(param.x2)
        ret.append(param.y2)
        ret.append(param.rad)
    else:
        ret = [0]
    return ret


def generate_pose(x, y, z, ox, oy, oz, ow):
    pose_goal = geometry_msgs.msg.Pose()
    pose_goal.position.x = x
    pose_goal.position.y = y
    pose_goal.position.z = z
    pose_goal.orientation.x = ox
    pose_goal.orientation.y = oy
    pose_goal.orientation.z = oz
    pose_goal.orientation.w = ow
    return pose_goal


def list_to_pose(param):
    if len(param) == 7:
        return generate_pose(
            param[0],
            param[1],
            param[2],
            param[3],
            param[4],
            param[5],
            param[6],
        )
    else:
        print("ERROR: Size of array not fit.")
        return generate_pose(0, 0, 0, 0, 0, 0, 0)

def list_to_cartesian_position(param):
    ret = CartesianPosition()
    ret.x1, ret.y1, ret.x2, ret.y2, ret.rad = param
    return ret


def euler_from_pose(param):
    quaternion_list = [
        param.orientation.x,
        param.orientation.y,
        param.orientation.z,
        param.orientation.w,
    ]
    return euler_from_quaternion(quaternion_list)


def rad_to_deg(rad):
    return rad * 180 / pi


def deg_to_rad(deg):
    return deg * (pi / 180)


def abort_execution(msg):
    rospy.logerr(msg)
    sys.exit()

def end_func(msg):
    if AUTO_:
        rospy.sleep(sleep_time)
        print(msg)
    else:
        input(msg)
    

def main():
    try:
        print(sys.version)
        print("Move Interface")
        # input("Press 'Enter' to start.")  # initialize

        # Orientation set
        (pox, poy, poz, pow) = quaternion_from_euler(
            deg_to_rad(-180), deg_to_rad(0), deg_to_rad(-90)
        )

        ntlab = GripperNTLab(USE_COBOTTA)
        print(ntlab.get_current_pose())
        print(to_list(ntlab.current_gripper_pose))
        rospy.sleep(0.5)
        input("Press 'Enter' to start.")  # standby
        ntlab.init_finished = True
        position = [
            pick_position[0],
            pick_position[1],
            pick_position[2] + 0.04,
            pick_position[3],
            pick_position[4],
            pick_position[5],
            pick_position[6],
        ]
        if not ntlab.cobotta_execute_pose_goal(position, True):
            abort_execution("Couldn't execute, cobotta_execute_pose_goal")

        print("Execute [STANDBY] Position")
        (roll, pitch, yaw) = euler_from_pose(ntlab.get_current_pose())
        print(
            "roll:"
            + str(rad_to_deg(roll))
            + " pitch:"
            + str(rad_to_deg(pitch))
            + " yaw:"
            + str(rad_to_deg(yaw))
        )

        gripper_pos = standby_pos
        ntlab.gripper_set_pose(gripper_pos, 3)

        if not ntlab.gripper_execute_and_wait(2):
            abort_execution("Couldn't execute, gripper_execute_and_wait")
        
        end_func("Cobotta + Gripper: standby pose executed")

        print("standby z:" + str(position[2] + gripper_pos[0] + hand_offset_z))
        position = [
            pick_position[0],
            pick_position[1],
            pick_position[2],
            pick_position[3],
            pick_position[4],
            pick_position[5],
            pick_position[6],
        ]

        if not ntlab.cobotta_execute_pose_goal(position, True):
            abort_execution("Couldn't execute, cobotta_execute_pose_goal")

        (roll, pitch, yaw) = euler_from_pose(ntlab.get_current_pose())
        print(
            "roll:"
            + str(rad_to_deg(roll))
            + " pitch:"
            + str(rad_to_deg(pitch))
            + " yaw:"
            + str(rad_to_deg(yaw))
        )
        end_func("Cobotta: pick pose executed")
        ############################################################################
        # Pressure Limit
        ntlab.gripper_grip_limit_pressure()
        rospy.sleep(0.5)
        # Collect Y data + Calculate new grip pos
        new_grip_pos = to_list(ntlab.current_gripper_pose)
        if(not all_close(ntlab.cop_left.y,ntlab.cop_right.y,0.1)):
            if(ntlab.cop_left.y<ntlab.cop_right.y):
                new_grip_pos[0] = new_grip_pos[0] + (ntlab.cop_right.y-ntlab.cop_left.y)/1000
            else:
                new_grip_pos[2] = new_grip_pos[2] + (ntlab.cop_left.y-ntlab.cop_right.y)/1000
        end_func("grip with limit pressure executed")
        ############################################################################
        if WITH_COR:
            # Slightly Open
            gripper_pos = to_list(ntlab.current_gripper_pose)
            gripper_pos[1] -= 0.01
            gripper_pos[3] += 0.01
            ntlab.gripper_set_pose(gripper_pos, 3)

            if not ntlab.gripper_execute_and_wait(10):
                abort_execution("Could execute, gripper_execute_and_wait")
            end_func("slightly open executed")
            ############################################################################
            # Execute new grip position
            gripper_pos = to_list(ntlab.current_gripper_pose)
            gripper_pos[0] = new_grip_pos[0]
            gripper_pos[2] = new_grip_pos[2]
            ntlab.gripper_set_pose(gripper_pos, 3)

            if not ntlab.gripper_execute_and_wait(2):
                abort_execution("Couldn't execute, gripper_execute_and_wait")
            end_func("new grip position executed")
            ############################################################################
            # Pressure Limit
            ntlab.gripper_grip_limit_pressure()
            last_pos = to_list(ntlab.current_gripper_pose)
            end_func("grip with limit pressure executed")
            ############################################################################
            # Adjust center of rotation
            gripper_pos = to_list(ntlab.current_gripper_pose)
            gripper_pos[0] = standby_pos[0]
            gripper_pos[2] = standby_pos[2]
            ntlab.gripper_set_pose(gripper_pos, 3)

            if not ntlab.gripper_execute_and_wait(2):
                abort_execution("Couldn't execute, gripper_execute_and_wait")
            end_func("adjust center of rotation executed")
            ############################################################################
        ############################################################################
        # Rotate
            # Cobotta------------------------------------------------------
        position = [
            pick_position[0],
            pick_position[1],
            pick_position[2] + 0.03,
            pick_position[3],
            pick_position[4],
            pick_position[5],
            pick_position[6],
        ]
        if not ntlab.cobotta_execute_pose_goal(position, True):
            abort_execution("Couldn't execute, cobotta_execute_pose_goal")
        end_func("Cobotta: rotation position executed")
            # Gripper------------------------------------------------------
        gripper_pos = to_list(ntlab.current_gripper_pose)
        gripper_pos[4] = 3.14  # rotate
        ntlab.gripper_set_pose(gripper_pos, 10)

        if not ntlab.gripper_execute_and_wait(10):
            abort_execution("Could execute, gripper_execute_and_wait")
        end_func("Gripper: rotation executed")
        ############################################################################
        # slightly open
            # Cobotta------------------------------------------------------
        position = [
            place_position[0],
            place_position[1],
            place_position[2],
            place_position[3],
            place_position[4],
            place_position[5],
            place_position[6],
        ]
        if not ntlab.cobotta_execute_pose_goal(position, True):
            abort_execution("Couldn't execute, cobotta_execute_pose_goal")
        end_func("Cobotta: place position executed")
            # Gripper------------------------------------------------------
        gripper_pos = to_list(ntlab.current_gripper_pose)
        gripper_pos[1] -= 0.01
        gripper_pos[3] += 0.01
        ntlab.gripper_set_pose(gripper_pos, 3)

        if not ntlab.gripper_execute_and_wait(10):
            abort_execution("Could execute, gripper_execute_and_wait")
        end_func("Gripper: place position executed")
        ############################################################################
        # arm going up
        position = [
            place_position[0],
            place_position[1],
            place_position[2] + 0.01,
            place_position[3],
            place_position[4],
            place_position[5],
            place_position[6],
        ]

        if not ntlab.cobotta_execute_pose_goal(position, True):
            abort_execution("Couldn't execute, cobotta_execute_pose_goal")
        end_func("Cobotta: Going up position executed")
        ############################################################################
        # Standby
        #   Cobotta    
        position = [
            pick_position[0],
            pick_position[1],
            pick_position[2] + 0.04,
            pick_position[3],
            pick_position[4],
            pick_position[5],
            pick_position[6],
        ]
        ntlab.cobotta_execute_pose_goal(position, False)
        #   Gripper
        gripper_pos = standby_pos
        ntlab.gripper_set_pose(gripper_pos, 3)

        if not ntlab.gripper_execute_and_wait(10):
            abort_execution("Could execute, gripper_execute_and_wait")
        if not ntlab.cobotta_wait_execution(list_to_pose(position), 10):
            abort_execution("Failed to wait, cobotta_wait_execution")
        ###########################################################################
    except rospy.ROSInterruptException:
        print("error")
        return


if __name__ == "__main__":
    main()
