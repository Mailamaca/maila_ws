#!/bin/bash
set -e

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

echo "Downloading maila-rosdep from maila_packages and making them available to rosdep. "
sudo sh -c 'mkdir -p /usr/share/rosdep'
sudo sh -c 'curl https://raw.githubusercontent.com/Mailamaca/maila_packages/main/maila-rosdep.yaml > /usr/share/rosdep/maila-rosdep.yaml'
sudo sh -c 'echo yaml file:////usr/share/rosdep/maila-rosdep.yaml >> /etc/ros/rosdep/sources.list.d/10-maila.list'

echo "Adding sources for Maila packages..."
# see https://github.com/Mailamaca/maila_packages/blob/jammy-humble/README.md
echo "deb [trusted=yes] https://raw.githubusercontent.com/Mailamaca/maila_packages/jammy-humble/ ./" | sudo tee /etc/apt/sources.list.d/Mailamaca_maila_packages.list
echo "yaml https://raw.githubusercontent.com/Mailamaca/maila_packages/jammy-humble/local.yaml humble" | sudo tee /etc/ros/rosdep/sources.list.d/1-Mailamaca_maila_packages.list
echo "...finished."

echo "Installing rosdep."
sudo apt update
rosdep update
rosdep install --from-paths $SCRIPT_DIR/../src --ignore-src -y
