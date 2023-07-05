xhost +local:root &&

docker run -itd --rm \
--privileged \
--net=host \
--env=NVIDIA_VISIBLE_DEVICES=all \
--env=NVIDIA_DRIVER_CAPABILITIES=all \
--env=DISPLAY \
--env=QT_X11_NO_MITSHM=1 \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e NVIDIA_VISIBLE_DEVICES=0 \
--runtime=nvidia \
--name=gazebo_ros \
gazebo_workspace:ros /bin/bash && \

docker cp ./testmodels/mav_cam/. gazebo_ros:/PX4-Autopilot/Tools/sitl_gazebo/models/mav_cam/. && \
docker cp ./testmodels/rgb_cam/. gazebo_ros:/PX4-Autopilot/Tools/sitl_gazebo/models/rgb_cam/. && \

docker attach gazebo_ros

# --rm    : remove the container after exit

# -it     : turn the terminal interactions on

# -v $(pwd)/workspace:/workspace  : synchronize the workspace directory

# --volume /tmp/.X11-unix:/tmp/.X11-unix:ro   : for GUI display
# -e DISPLAY=unix$DISPLAY

# --net=host  : set container id as the id of the host

# --privileged    : give sudo rights

# --name gazebo_workspace : name of container

# gazebo_workspace : target image
