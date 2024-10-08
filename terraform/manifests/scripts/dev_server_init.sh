#! /bin/bash

set -x

# updating the package manager
yes | sudo apt update 

# install pip and python
yes | sudo apt install python3
yes | sudo apt install python3-pip
yes | sudo apt install python3-docker

# docker installation
# Add Docker's official GPG key:
yes | sudo apt-get update
yes | sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
yes | sudo apt-get update

yes | sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

yes | usermod -aG docker ubuntu
yes | sudo reboot

# changing the permissions of private key file
sudo chmod 400 /home/ubuntu/.ssh/dev_ec2