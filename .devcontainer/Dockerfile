FROM docker.io/althack/ros2:humble-dev

# ** [Optional] Uncomment this section to install additional packages. **
#
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
#    && apt-get upgrade -y \
   && apt-get -y install --no-install-recommends \
        # Utils
        zsh less\
        # Dependecny for Stage package.
        ros-humble-cv-bridge libfltk1.3-dev libgl1-mesa-dev libltdl-dev libjpeg-dev libpng-dev \
        # rviz2
        ros-humble-rviz2 \
        # ament
        ros-humble-ament-cmake-clang-format\
        # Install llvm (https://apt.llvm.org/)
        clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang\
   # Clean up
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*
RUN /bin/python3 -m pip install pylint
ENV DEBIAN_FRONTEND=dialog

ARG WORKSPACE
RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/ros/.bashrc

# Setup colcon cd
# https://docs.ros.org/en/galactic/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html#setup-colcon-cd
RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> /home/ros/.bashrc
RUN echo "export _colcon_cd_root=/opt/ros/galactic/" >> /home/ros/.bashrc

# Setup colcon tab completion
# https://docs.ros.org/en/galactic/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html#setup-colcon-tab-completion
RUN echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> /home/ros/.bashrc
RUN echo "alias ign='touch COLCON_IGNORE'" >> /home/ros/.bashrc
