#!/bin/bash
set -e

ROS2_WORKSPACE=$(dirname "${BASH_SOURCE[0]}")

# Set the default build type
BUILD_TYPE=RelWithDebInfo
colcon build \
        --merge-install \
        --symlink-install \
        --cmake-args "-DCMAKE_BUILD_TYPE=$BUILD_TYPE" "-DCMAKE_EXPORT_COMPILE_COMMANDS=On" \
        -Wall -Wextra -Wpedantic

./generate_compile_cmds.py --catkin_ws $ROS2_WORKSPACE
