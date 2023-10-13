#!/bin/bash
set -e

ROS2_WORKSPACE=$(dirname "${BASH_SOURCE[0]}")

rm -rf ${ROS2_WORKSPACE}/log/ ${ROS2_WORKSPACE}/install/ ${ROS2_WORKSPACE}/build
