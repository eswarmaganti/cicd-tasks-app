#! /bin/bash

# updating the package manager
yes | sudo apt update 

# java installation
yes | sudo apt install fontconfig openjdk-17-jre
echo `java -version`

# jenkins installation
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
yes | sudo apt-get update
yes | sudo apt-get install jenkins


# install pip and python
yes | sudo apt install python3
yes | sudo apt install python3-pip
yes | sudo apt install python3-docker

# ansible installation
yes | sudo apt update
yes | sudo apt install software-properties-common
yes | sudo add-apt-repository --yes --update ppa:ansible/ansible
yes | sudo apt install ansible



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

# applying the permissions to ubuntu and jenkins user to run docker cli commands
yes | usermod -aG docker ubuntu
yes | usermod -aG docker jenkins

# change the permissions for private key
chmod 400 ~/.ssh/dev_ec2
yes | sudo reboot