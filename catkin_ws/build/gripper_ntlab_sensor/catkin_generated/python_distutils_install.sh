#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_sensor"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/tw017/Desktop/PipetteDetect/catkin_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/tw017/Desktop/PipetteDetect/catkin_ws/install/lib/python3/dist-packages:/home/tw017/Desktop/PipetteDetect/catkin_ws/build/gripper_ntlab_sensor/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/tw017/Desktop/PipetteDetect/catkin_ws/build/gripper_ntlab_sensor" \
    "/usr/bin/python3" \
    "/home/tw017/Desktop/PipetteDetect/catkin_ws/src/gripper_ntlab/gripper_ntlab_sensor/setup.py" \
     \
    build --build-base "/home/tw017/Desktop/PipetteDetect/catkin_ws/build/gripper_ntlab_sensor" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/tw017/Desktop/PipetteDetect/catkin_ws/install" --install-scripts="/home/tw017/Desktop/PipetteDetect/catkin_ws/install/bin"
