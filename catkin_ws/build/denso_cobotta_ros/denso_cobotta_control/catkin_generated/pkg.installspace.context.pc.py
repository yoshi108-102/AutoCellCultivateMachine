# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "controller_manager;hardware_interface;joint_limits_interface;roscpp;std_msgs;transmission_interface;denso_cobotta_lib".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-ldenso_cobotta_control".split(';') if "-ldenso_cobotta_control" != "" else []
PROJECT_NAME = "denso_cobotta_control"
PROJECT_SPACE_DIR = "/usr/local"
PROJECT_VERSION = "1.2.4"