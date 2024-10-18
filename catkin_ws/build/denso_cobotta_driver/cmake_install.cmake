# Install script for directory: /home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/tw017/Desktop/PipetteDetect/catkin_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
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
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tw017/Desktop/PipetteDetect/catkin_ws/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/tw017/Desktop/PipetteDetect/catkin_ws/install" TYPE PROGRAM FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tw017/Desktop/PipetteDetect/catkin_ws/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/tw017/Desktop/PipetteDetect/catkin_ws/install" TYPE PROGRAM FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tw017/Desktop/PipetteDetect/catkin_ws/install/setup.bash;/home/tw017/Desktop/PipetteDetect/catkin_ws/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/tw017/Desktop/PipetteDetect/catkin_ws/install" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/setup.bash"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tw017/Desktop/PipetteDetect/catkin_ws/install/setup.sh;/home/tw017/Desktop/PipetteDetect/catkin_ws/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/tw017/Desktop/PipetteDetect/catkin_ws/install" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/setup.sh"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tw017/Desktop/PipetteDetect/catkin_ws/install/setup.zsh;/home/tw017/Desktop/PipetteDetect/catkin_ws/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/tw017/Desktop/PipetteDetect/catkin_ws/install" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/setup.zsh"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/tw017/Desktop/PipetteDetect/catkin_ws/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/tw017/Desktop/PipetteDetect/catkin_ws/install" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/.rosinstall")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_driver/srv" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetMotorState.srv"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetMotorState.srv"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearError.srv"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearRobotError.srv"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ClearSafeState.srv"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetBrakeState.srv"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/GetBrakeState.srv"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/SetLEDState.srv"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/srv/ExecCalset.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_driver/msg" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/RobotState.msg"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/msg/SafeState.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_driver/cmake" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/denso_cobotta_driver-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_driver/include/denso_cobotta_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_driver/share/roseus/ros/denso_cobotta_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_driver/share/common-lisp/ros/denso_cobotta_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_driver/share/gennodejs/ros/denso_cobotta_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_driver/lib/python3/dist-packages/denso_cobotta_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_driver/lib/python3/dist-packages/denso_cobotta_driver")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/denso_cobotta_driver.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_driver/cmake" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/denso_cobotta_driver-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_driver/cmake" TYPE FILE FILES
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/denso_cobotta_driverConfig.cmake"
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/catkin_generated/installspace/denso_cobotta_driverConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/denso_cobotta_driver" TYPE FILE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/denso_cobotta_ros/denso_cobotta_driver/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver" TYPE EXECUTABLE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_driver/lib/denso_cobotta_driver/denso_cobotta_driver")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver"
         OLD_RPATH "/opt/ros/noetic/lib:/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_lib/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver" TYPE EXECUTABLE FILES "/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_driver/lib/denso_cobotta_driver/denso_cobotta_driver")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver"
         OLD_RPATH "/opt/ros/noetic/lib:/home/tw017/Desktop/PipetteDetect/catkin_ws/devel/.private/denso_cobotta_lib/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/denso_cobotta_driver/denso_cobotta_driver")
    endif()
  endif()
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/gtest/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/denso_cobotta_driver/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
