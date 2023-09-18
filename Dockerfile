# docker build . -t xsens_mti_2004
# docker run -it --network host --privileged xsens_mti_2004
FROM ros:noetic-ros-base

ENV DEBIAN_FRONTEND="noninteractive"

# be able to source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -y
RUN apt-get upgrade -y

# TODO(lucasw) COPY from current directory instead, use local modifications
# RUN apt-get install -yqq ros-noetic-xsens-mti-driver
# RUN apt-get install -yqq ros-noetic-rospack
# RUN source /opt/ros/noetic/setup.bash && rospack find xsens_mti_driver
# RUN find /opt/ros/noetic/share/xsens_mti_driver
# RUN cat /opt/ros/noetic/share/xsens_mti_driver/param/xsens_mti_node.yaml

# CMD source /opt/ros/noetic/setup.bash && roslaunch xsens_mti_driver xsens_mti_node.launch

RUN apt-get install -yqq git
RUN apt-get install -yqq ros-noetic-catkin python3-catkin-tools ros-noetic-cmake-modules

WORKDIR catkin_ws/src
RUN pwd
RUN git clone https://github.com/nobleo/xsens_mti_driver.git

RUN apt-get install -yqq ros-noetic-tf2 ros-noetic-tf2-ros ros-noetic-diagnostic-updater
WORKDIR ..
RUN source /opt/ros/noetic/setup.bash && catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release -Wno-deprecated
RUN source /opt/ros/noetic/setup.bash && catkin build

CMD source devel/setup.bash && roslaunch xsens_mti_driver xsens_mti_node.launch
