# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "controller_manager;hardware_interface;joint_limits_interface;message_runtime;roscpp;std_msgs;transmission_interface;actionlib;actionlib_msgs;denso_cobotta_lib".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-ldenso_cobotta_gripper".split(';') if "-ldenso_cobotta_gripper" != "" else []
PROJECT_NAME = "denso_cobotta_gripper"
PROJECT_SPACE_DIR = "/usr/local"
PROJECT_VERSION = "1.2.4"
