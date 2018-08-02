#!/bin/bash

# https://docs.docker.com/install/linux/docker-ce/debian/#install-using-the-convenience-script

# check if docker is not already installed
if [ -f /etc/apt/sources.list.d/docker.list ]; then
  echo "error: /etc/apt/sources.list.d/docker.list already exists"
  echo "giving up and not attempting to install docker"
  exit 1
fi

# download latest get-docker.sh
if [ -f get-docker.sh ]; then
  echo "get-docker.sh already downloaded.  removing to ensure latest copy is used"
  rm get-docker.sh
fi

curl -fsSL get.docker.com -o get-docker.sh
if [ $? -eq 0 ]; then
  sudo sh ./get-docker.sh
else
  echo "failed to download get-docker.sh from get.docker.com"
  exit 1
fi

if [ $? -eq 0 ]; then
  echo "install of docker successful"
else
  echo "docker install failed..."
  exit 1
fi

# make sure to add current user to docker group
echo "add current user to docker group"
sudo usermod -aG docker $USER
# flag need to reboot/logout/login 

# install docker-compose
sudo pip install docker-compose


