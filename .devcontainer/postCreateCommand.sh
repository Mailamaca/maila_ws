#!/bin/bash
set -e

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

pushd $SCRIPT_DIR/../rosdep
echo "echo yaml file:///${PWD}/maila-rosdep.yaml >> /etc/ros/rosdep/sources.list.d/10-maila.list"
sudo sh -c 'echo yaml file:///${PWD}/maila-rosdep.yaml >> /etc/ros/rosdep/sources.list.d/10-maila.list'
popd

echo "Installing rosdep..."
sudo apt update
rosdep update
rosdep install --from-paths src --ignore-src -y
echo "...finished."
