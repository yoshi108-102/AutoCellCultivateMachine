# Install script for directory: /home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core/msg" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/msg/ExJoints.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/msg/Joints.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/msg/PoseData.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/msg/UserIO.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core/action" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/action/DriveString.action"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/action/DriveValue.action"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/action/MoveString.action"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/action/MoveValue.action"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core/msg" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveStringAction.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveStringActionGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveStringActionResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveStringActionFeedback.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveStringGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveStringResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveStringFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core/msg" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveValueAction.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveValueActionGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveValueActionResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveValueActionFeedback.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveValueGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveValueResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/DriveValueFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core/msg" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveStringAction.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveStringActionGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveStringActionResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveStringActionFeedback.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveStringGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveStringResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveStringFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core/msg" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveValueAction.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveValueActionGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveValueActionResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveValueActionFeedback.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveValueGoal.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveValueResult.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/denso_robot_core/msg/MoveValueFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core/cmake" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/denso_robot_ros/denso_robot_core/catkin_generated/installspace/denso_robot_core-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/include/denso_robot_core")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/roseus/ros/denso_robot_core")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/common-lisp/ros/denso_robot_core")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/share/gennodejs/ros/denso_robot_core")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/lib/python3/dist-packages/denso_robot_core")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/lib/python3/dist-packages/denso_robot_core")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/denso_robot_ros/denso_robot_core/catkin_generated/installspace/denso_robot_core.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core/cmake" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/denso_robot_ros/denso_robot_core/catkin_generated/installspace/denso_robot_core-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core/cmake" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/denso_robot_ros/denso_robot_core/catkin_generated/installspace/denso_robot_coreConfig.cmake"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/denso_robot_ros/denso_robot_core/catkin_generated/installspace/denso_robot_coreConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libdenso_robot_core.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libdenso_robot_core.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libdenso_robot_core.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/lib/libdenso_robot_core.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libdenso_robot_core.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libdenso_robot_core.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libdenso_robot_core.so"
         OLD_RPATH "/opt/ros/noetic/lib:/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libdenso_robot_core.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_robot_core/denso_robot_core_exec" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_robot_core/denso_robot_core_exec")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_robot_core/denso_robot_core_exec"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/denso_robot_core" TYPE EXECUTABLE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/lib/denso_robot_core/denso_robot_core_exec")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_robot_core/denso_robot_core_exec" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_robot_core/denso_robot_core_exec")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_robot_core/denso_robot_core_exec"
         OLD_RPATH "/opt/ros/noetic/lib:/home/tw017/Desktop/PipetteDetect/catkin_ws/src/build/devel/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_robot_core/denso_robot_core_exec")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/denso_robot_core" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/include/denso_robot_core/" FILES_MATCHING REGEX "/[^/]*\\.h$" REGEX "/\\.svn$" EXCLUDE)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/launch")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_robot_core" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_robot_ros/denso_robot_core/config")
endif()

