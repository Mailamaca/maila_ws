#!/bin/bash
set -e

# https://stackoverflow.com/questions/28279862/docker-and-bash-history
echo "export HISTFILE=~/.persistent-volume/.bash_history" >> /home/ros/.bashrc
export HISTFILE=~/.persistent-volume/.bash_history
touch $HISTFILE

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
# https://stackoverflow.com/questions/28279862/docker-and-bash-history
export HISTFILE=~/.persistent-volume/.bash_history
echo "export HISTFILE=${HISTFILE}" >> /home/ros/.bashrc
touch $HISTFILE

# Set Maila apt sources.
echo "deb [trusted=yes] https://raw.githubusercontent.com/Mailamaca/maila_packages/jammy-humble/ ./" | sudo tee /etc/apt/sources.list.d/Mailamaca_maila_packages.list
echo "yaml https://raw.githubusercontent.com/Mailamaca/maila_packages/jammy-humble/local.yaml humble" | sudo tee /etc/ros/rosdep/sources.list.d/1-Mailamaca_maila_packages.list

# maila local packages
echo "yaml https://raw.githubusercontent.com/Mailamaca/maila_packages/jammy-humble/local.yaml" | sudo tee /etc/ros/rosdep/sources.list.d/10-maila.list
# maila external packages
echo "yaml https://raw.githubusercontent.com/Mailamaca/maila_packages/main/maila-rosdep.yaml" | sudo tee /etc/ros/rosdep/sources.list.d/10-maila.list

pushd "${SCRIPT_DIR}/../rosdep"
echo "echo yaml file:///${PWD}/maila-rosdep.yaml >> /etc/ros/rosdep/sources.list.d/10-maila.list"
sudo sh -c 'echo yaml file:///${PWD}/maila-rosdep.yaml >> /etc/ros/rosdep/sources.list.d/10-maila.list'
popd


echo "Installing rosdep..."
sudo apt update
rosdep update
rosdep install --from-paths $SCRIPT_DIR/../src --ignore-src -y
