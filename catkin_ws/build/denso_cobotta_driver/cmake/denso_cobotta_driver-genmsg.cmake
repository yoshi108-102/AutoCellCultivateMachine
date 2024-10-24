# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "denso_cobotta_driver: 2 messages, 9 services")

set(MSG_I_FLAGS "-Idenso_cobotta_driver:/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(denso_cobotta_driver_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv" NAME_WE)
add_custom_target(_denso_cobotta_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "denso_cobotta_driver" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_msg_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Services
_generate_srv_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_cpp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Module File
_generate_module_cpp(denso_cobotta_driver
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(denso_cobotta_driver_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(denso_cobotta_driver_generate_messages denso_cobotta_driver_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_cpp _denso_cobotta_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(denso_cobotta_driver_gencpp)
add_dependencies(denso_cobotta_driver_gencpp denso_cobotta_driver_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS denso_cobotta_driver_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)
_generate_msg_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Services
_generate_srv_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_eus(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Module File
_generate_module_eus(denso_cobotta_driver
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(denso_cobotta_driver_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(denso_cobotta_driver_generate_messages denso_cobotta_driver_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_eus _denso_cobotta_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(denso_cobotta_driver_geneus)
add_dependencies(denso_cobotta_driver_geneus denso_cobotta_driver_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS denso_cobotta_driver_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_msg_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Services
_generate_srv_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_lisp(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Module File
_generate_module_lisp(denso_cobotta_driver
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(denso_cobotta_driver_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(denso_cobotta_driver_generate_messages denso_cobotta_driver_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_lisp _denso_cobotta_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(denso_cobotta_driver_genlisp)
add_dependencies(denso_cobotta_driver_genlisp denso_cobotta_driver_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS denso_cobotta_driver_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)
_generate_msg_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Services
_generate_srv_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_nodejs(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Module File
_generate_module_nodejs(denso_cobotta_driver
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(denso_cobotta_driver_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(denso_cobotta_driver_generate_messages denso_cobotta_driver_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_nodejs _denso_cobotta_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(denso_cobotta_driver_gennodejs)
add_dependencies(denso_cobotta_driver_gennodejs denso_cobotta_driver_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS denso_cobotta_driver_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)
_generate_msg_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Services
_generate_srv_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)
_generate_srv_py(denso_cobotta_driver
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
)

### Generating Module File
_generate_module_py(denso_cobotta_driver
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(denso_cobotta_driver_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(denso_cobotta_driver_generate_messages denso_cobotta_driver_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv" NAME_WE)
add_dependencies(denso_cobotta_driver_generate_messages_py _denso_cobotta_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(denso_cobotta_driver_genpy)
add_dependencies(denso_cobotta_driver_genpy denso_cobotta_driver_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS denso_cobotta_driver_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/denso_cobotta_driver
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(denso_cobotta_driver_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/denso_cobotta_driver
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(denso_cobotta_driver_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/denso_cobotta_driver
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(denso_cobotta_driver_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/denso_cobotta_driver
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(denso_cobotta_driver_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/denso_cobotta_driver
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(denso_cobotta_driver_generate_messages_py std_msgs_generate_messages_py)
endif()
