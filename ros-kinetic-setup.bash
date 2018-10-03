#! /bin/bash

echo "Before installing, update packages"
sudo apt update -y
sudo apt upgrade -y

echo "Setup your computer to accept software from packages.ros.org."
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Setup your keys
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
echo "Updating..."

# Update
sudo apt-get update -y
echo "Start installing ROS"
sudo apt-get install ros-kinetic-desktop-full -y
sudo apt-get -y install ros-kinetic-rqt* -y

# Initialize rosdep tools
sudo rosdep init
rosdep update

# Write source command in .bashrc
output_text="/opt/ros/kinetic/setup.bash"
if grep  $output_text ~/.bashrc; then
  echo "already exist!"
  else echo "source "$output_text >> ~/.bashrc
fi
# For face_expression gtx_error
output_text="DISPLAY=:0.0"
if grep  $output_text ~/.bashrc; then
  echo "already exist!"
  else echo "export "$output_text >> ~/.bashrc
fi
source ~/.bashrc

echo "Install other packages for ROS."
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential -y

echo "Making catkin workspace"
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make

# Write source command in .bashrc
output_text="~/ros/devel/setup.bash"
if grep  $output_text ~/.bashrc; then
  echo "already exist!"
  else echo "source "$output_text >> ~/.bashrc
fi
source ~/.bashrc
output_text="LIBGL_ALWAYS_SOFTWARE=1"
if grep  $output_text ~/.bashrc; then
  echo "already exist!"
  else echo "export "$output_text >> ~/.bashrc
fi
source ~/.bashrc

echo "Finished!!"