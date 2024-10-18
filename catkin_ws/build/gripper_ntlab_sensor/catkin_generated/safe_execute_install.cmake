execute_process(COMMAND "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/gripper_ntlab_sensor/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/tw017/Desktop/PipetteDetect/catkin_ws/build/gripper_ntlab_sensor/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
