FROM docker.io/althack/ros2:humble-dev

# Install additional packages.
#
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
#    && apt-get upgrade -y \
   && apt-get -y install --no-install-recommends \
        ros-humble-rviz2 \
        # Utils
        less ipython3 python3-autopep8 \
        # Bash script formatter.
        shfmt \
        # Install llvm (https://apt.llvm.org/)
        clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev \
        libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 \
        lld lldb llvm-dev llvm-runtime llvm python3-clang \
        # Utility
        ros-humble-ament-pycodestyle \
   # Clean up
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*

# Python requirements
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# FIX  error creating runtime directory '/run/user/1000' (Permission denied)
RUN mkdir /run/user/1000 && chown ros:ros /run/user/1000 && chmod 0700 /run/user/1000

ENV DEBIAN_FRONTEND=dialog

ARG WORKSPACE
RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/ros/.bashrc
# Configure gazebo this avoid problems with the render engine of gzclient.
RUN echo "if [ -f /usr/share/gazebo-11/setup.sh ]; then source /usr/share/gazebo-11/setup.sh; fi" >> /home/ros/.bashrc

# Setup colcon cd
# https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html#setup-colcon-cd
RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> /home/ros/.bashrc
RUN echo "export _colcon_cd_root=/opt/ros/humble/" >> /home/ros/.bashrc
RUN echo "export RCUTILS_CONSOLE_OUTPUT_FORMAT='[{severity} {time}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})'"  >> /home/ros/.bashrc

# Setup colcon tab completion
# https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html#setup-colcon-tab-completion
RUN echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> /home/ros/.bashrc

# Setup useful aliases
RUN echo "alias ign='touch COLCON_IGNORE'" >> /home/ros/.bashrc
