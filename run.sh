xhost +local:root &&
docker run --rm -it \
-v $(pwd)/sim_ws:/workspace/src \
--volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
-e DISPLAY=unix$DISPLAY \
--net=host \
--privileged \
--name gazeboworkspace \
gazebo_workspace:ros /bin/bash


# --rm    : remove the container after exit

# -it     : turn the terminal interactions on

# -v $(pwd)/workspace:/workspace  : synchronize the workspace directory

# --volume /tmp/.X11-unix:/tmp/.X11-unix:ro   : for GUI display
# -e DISPLAY=unix$DISPLAY

# --net=host  : set container id as the id of the host

# --privileged    : give sudo rights

# --name gazebo_workspace : name of container

# gazebo_workspace : target image
