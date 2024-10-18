# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "gripper_ntlab_msgs: 2 messages, 0 services")

set(MSG_I_FLAGS "-Igripper_ntlab_msgs:/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(gripper_ntlab_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg" NAME_WE)
add_custom_target(_gripper_ntlab_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gripper_ntlab_msgs" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg" ""
)

get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg" NAME_WE)
add_custom_target(_gripper_ntlab_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gripper_ntlab_msgs" "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gripper_ntlab_msgs
)
_generate_msg_cpp(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gripper_ntlab_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(gripper_ntlab_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gripper_ntlab_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(gripper_ntlab_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(gripper_ntlab_msgs_generate_messages gripper_ntlab_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_cpp _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_cpp _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gripper_ntlab_msgs_gencpp)
add_dependencies(gripper_ntlab_msgs_gencpp gripper_ntlab_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gripper_ntlab_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gripper_ntlab_msgs
)
_generate_msg_eus(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gripper_ntlab_msgs
)

### Generating Services

### Generating Module File
_generate_module_eus(gripper_ntlab_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gripper_ntlab_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(gripper_ntlab_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(gripper_ntlab_msgs_generate_messages gripper_ntlab_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_eus _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_eus _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gripper_ntlab_msgs_geneus)
add_dependencies(gripper_ntlab_msgs_geneus gripper_ntlab_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gripper_ntlab_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gripper_ntlab_msgs
)
_generate_msg_lisp(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gripper_ntlab_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(gripper_ntlab_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gripper_ntlab_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(gripper_ntlab_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(gripper_ntlab_msgs_generate_messages gripper_ntlab_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_lisp _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_lisp _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gripper_ntlab_msgs_genlisp)
add_dependencies(gripper_ntlab_msgs_genlisp gripper_ntlab_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gripper_ntlab_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gripper_ntlab_msgs
)
_generate_msg_nodejs(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gripper_ntlab_msgs
)

### Generating Services

### Generating Module File
_generate_module_nodejs(gripper_ntlab_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gripper_ntlab_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(gripper_ntlab_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(gripper_ntlab_msgs_generate_messages gripper_ntlab_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_nodejs _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_nodejs _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gripper_ntlab_msgs_gennodejs)
add_dependencies(gripper_ntlab_msgs_gennodejs gripper_ntlab_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gripper_ntlab_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gripper_ntlab_msgs
)
_generate_msg_py(gripper_ntlab_msgs
  "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gripper_ntlab_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(gripper_ntlab_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gripper_ntlab_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(gripper_ntlab_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(gripper_ntlab_msgs_generate_messages gripper_ntlab_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/JointPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_py _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_msgs/msg/CartesianPosition.msg" NAME_WE)
add_dependencies(gripper_ntlab_msgs_generate_messages_py _gripper_ntlab_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gripper_ntlab_msgs_genpy)
add_dependencies(gripper_ntlab_msgs_genpy gripper_ntlab_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gripper_ntlab_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gripper_ntlab_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gripper_ntlab_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gripper_ntlab_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gripper_ntlab_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gripper_ntlab_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gripper_ntlab_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gripper_ntlab_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gripper_ntlab_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gripper_ntlab_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gripper_ntlab_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gripper_ntlab_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
