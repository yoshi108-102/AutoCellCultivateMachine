# Install script for directory: /home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_gripper

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_gripper/action" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_gripper/action/GripperMove.action"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_gripper/action/VacuumMove.action"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_gripper/msg" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/GripperMoveAction.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/GripperMoveActionGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/GripperMoveActionResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/GripperMoveActionFeedback.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/GripperMoveGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/GripperMoveResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/GripperMoveFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_gripper/msg" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/VacuumMoveAction.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/VacuumMoveActionGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/VacuumMoveActionResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/VacuumMoveActionFeedback.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/VacuumMoveGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/VacuumMoveResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/denso_cobotta_gripper/msg/VacuumMoveFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_gripper/cmake" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_ros/denso_cobotta_gripper/catkin_generated/installspace/denso_cobotta_gripper-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/include/denso_cobotta_gripper")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/roseus/ros/denso_cobotta_gripper")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/common-lisp/ros/denso_cobotta_gripper")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/share/gennodejs/ros/denso_cobotta_gripper")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/lib/python3/dist-packages/denso_cobotta_gripper")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/lib/python3/dist-packages/denso_cobotta_gripper")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_ros/denso_cobotta_gripper/catkin_generated/installspace/denso_cobotta_gripper.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_gripper/cmake" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_ros/denso_cobotta_gripper/catkin_generated/installspace/denso_cobotta_gripper-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_gripper/cmake" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_ros/denso_cobotta_gripper/catkin_generated/installspace/denso_cobotta_gripperConfig.cmake"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_ros/denso_cobotta_gripper/catkin_generated/installspace/denso_cobotta_gripperConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_gripper" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_gripper/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper" TYPE EXECUTABLE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/lib/denso_cobotta_gripper/denso_cobotta_gripper")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper"
         OLD_RPATH "/opt/ros/noetic/lib:/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper" TYPE EXECUTABLE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/lib/denso_cobotta_gripper/denso_cobotta_gripper")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper"
         OLD_RPATH "/opt/ros/noetic/lib:/home/tw017/Desktop/PipetteDetect/catkin_ws/build/devel/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_gripper/denso_cobotta_gripper")
    endif()
  endif()
endif()

