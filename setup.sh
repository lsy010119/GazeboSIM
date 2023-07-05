## pull gazebo image
docker pull gazebo:libgazebo11-focal

### Build image###
docker build --tag gazebo_workspace:ros .
