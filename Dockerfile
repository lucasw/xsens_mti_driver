# docker build . -t xsens_mti_2004
# docker run -it --network host --privileged xsens_mti_2004
FROM ros:noetic-ros-base

ENV DEBIAN_FRONTEND="noninteractive"

# be able to source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -y

# TODO(lucasw) COPY from current directory instead, use local modifications
RUN apt-get install -yqq ros-noetic-xsens-mti-driver

# RUN mkdir catkin_ws/src -p
# WORKDIR catkin_ws/src
# RUN apt-get install -yqq git
# RUN git clone git@github.com:nobleo/xsens_mti_driver.git

# RUN apt-cache search catkin
# RUN apt-get install -yqq catkin
# WORKDIR catkin_ws
# RUN catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release -Wno-deprecated
# RUN catkin build
# CMD source devel/setup.bash && roslaunch xsens_mti_driver xsens_mti_node.launch

CMD source /opt/ros/noetic/setup.bash && roslaunch xsens_mti_driver xsens_mti_node.launch
