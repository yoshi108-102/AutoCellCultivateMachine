# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "bcap_service: 1 messages, 1 services")

set(MSG_I_FLAGS "-Ibcap_service:/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(bcap_service_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg" NAME_WE)
add_custom_target(_bcap_service_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "bcap_service" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv" NAME_WE)
add_custom_target(_bcap_service_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "bcap_service" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv" "bcap_service/variant"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/bcap_service
)

### Generating Services
_generate_srv_cpp(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv"
  "${MSG_I_FLAGS}"
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/bcap_service
)

### Generating Module File
_generate_module_cpp(bcap_service
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/bcap_service
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(bcap_service_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(bcap_service_generate_messages bcap_service_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg" NAME_WE)
add_dependencies(bcap_service_generate_messages_cpp _bcap_service_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv" NAME_WE)
add_dependencies(bcap_service_generate_messages_cpp _bcap_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(bcap_service_gencpp)
add_dependencies(bcap_service_gencpp bcap_service_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS bcap_service_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/bcap_service
)

### Generating Services
_generate_srv_eus(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv"
  "${MSG_I_FLAGS}"
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/bcap_service
)

### Generating Module File
_generate_module_eus(bcap_service
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/bcap_service
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(bcap_service_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(bcap_service_generate_messages bcap_service_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg" NAME_WE)
add_dependencies(bcap_service_generate_messages_eus _bcap_service_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv" NAME_WE)
add_dependencies(bcap_service_generate_messages_eus _bcap_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(bcap_service_geneus)
add_dependencies(bcap_service_geneus bcap_service_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS bcap_service_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/bcap_service
)

### Generating Services
_generate_srv_lisp(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv"
  "${MSG_I_FLAGS}"
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/bcap_service
)

### Generating Module File
_generate_module_lisp(bcap_service
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/bcap_service
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(bcap_service_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(bcap_service_generate_messages bcap_service_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg" NAME_WE)
add_dependencies(bcap_service_generate_messages_lisp _bcap_service_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv" NAME_WE)
add_dependencies(bcap_service_generate_messages_lisp _bcap_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(bcap_service_genlisp)
add_dependencies(bcap_service_genlisp bcap_service_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS bcap_service_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/bcap_service
)

### Generating Services
_generate_srv_nodejs(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv"
  "${MSG_I_FLAGS}"
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/bcap_service
)

### Generating Module File
_generate_module_nodejs(bcap_service
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/bcap_service
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(bcap_service_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(bcap_service_generate_messages bcap_service_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg" NAME_WE)
add_dependencies(bcap_service_generate_messages_nodejs _bcap_service_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv" NAME_WE)
add_dependencies(bcap_service_generate_messages_nodejs _bcap_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(bcap_service_gennodejs)
add_dependencies(bcap_service_gennodejs bcap_service_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS bcap_service_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/bcap_service
)

### Generating Services
_generate_srv_py(bcap_service
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv"
  "${MSG_I_FLAGS}"
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/bcap_service
)

### Generating Module File
_generate_module_py(bcap_service
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/bcap_service
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(bcap_service_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(bcap_service_generate_messages bcap_service_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/msg/variant.msg" NAME_WE)
add_dependencies(bcap_service_generate_messages_py _bcap_service_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/bcap_service/srv/bcap.srv" NAME_WE)
add_dependencies(bcap_service_generate_messages_py _bcap_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(bcap_service_genpy)
add_dependencies(bcap_service_genpy bcap_service_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS bcap_service_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/bcap_service)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/bcap_service
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(bcap_service_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/bcap_service)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/bcap_service
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(bcap_service_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/bcap_service)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/bcap_service
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(bcap_service_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/bcap_service)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/bcap_service
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(bcap_service_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/bcap_service)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/bcap_service\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/bcap_service
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(bcap_service_generate_messages_py std_msgs_generate_messages_py)
endif()
