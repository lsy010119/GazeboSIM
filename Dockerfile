FROM gazebo:libgazebo11-focal

# Turn y/n interrupts off
ENV DEBIAN_FRONTEND=noninteractive

# apt update
RUN \
	apt update -y && \
	apt upgrade -y && \
	apt install -y nano &&\
    apt install -y git && \
	apt install -y curl

# install python3
RUN \
	apt install -y python3-pip

# install python libraries
RUN \
    pip3 install numpy           && \
    pip3 install matplotlib      && \
    pip3 install cvxpy           && \
    pip3 install scipy           && \
    pip3 install opencv-python   && \
    pip3 install mavsdk          && \
    pip3 install asyncio         && \
    pip3 install jinja2          && \
    pip3 install numpy toml


# install c++ libraries
# RUN \
# 	apt install libgl1-mesa-glx -y && \
# 	apt install -y libglib2.0-0 

# RUN \
# 	apt install x11-apps -y && \
# 	apt install libeigen3-dev -y && \
# 	apt install libjpeg-dev libtiff5-dev libpng-dev -y && \
# 	apt install libavcodec-dev libavformat-dev libswscale-dev -y && \
# 	apt install libdc1394-22-dev libxvidcore-dev libx264-dev -y && \
# 	apt install libxine2-dev libv4l-dev v4l-utils -y && \
# 	apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev -y && \
# 	apt install libgtk-3-dev -y && \
# 	apt install -y cmake g++ wget unzip 
# RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/4.x.zip
# RUN unzip opencv.zip

# # Build opencv c++
# RUN mkdir -p build
# WORKDIR /build

# RUN cmake  ../opencv-4.x
# RUN make -j4
# RUN make install


# Install ROS Noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

RUN apt update

RUN apt install ros-noetic-desktop-full -y


WORKDIR /

### PX4 Firmware sources ###
RUN git clone -b v1.11.0-beta4 --depth 1 https://github.com/PX4/PX4-Autopilot.git

### Creating workspace ###
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Setup catkin workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
                 mkdir -p workspace/src && \
                 cd workspace/ && \
                 catkin_make"

RUN echo "source /workspace/devel/setup.bash" >> ~/.bashrc

# This is needed to run GUI applications
ENV DISPLAY localhost:0 

