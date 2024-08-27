#! /bin/bash

set -x
# updating the package manager
yes | sudo apt update 

# java installation
echo '--- Java Installation ---'
yes | sudo apt install fontconfig openjdk-17-jre
echo `java -version`

# jenkins installation
echo '--- Jenkins Server Installation ---'
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
yes | sudo apt-get update
yes | sudo apt-get install jenkins


# install pip and python
echo '--- PYTHON3 and PIP installation ---'
yes | sudo apt install python3
yes | sudo apt install python3-pip
yes | sudo apt install python3-docker

# ansible installation
echo '--- Ansible configuration management tool installation ---'
yes | sudo apt install software-properties-common
yes | sudo add-apt-repository --yes --update ppa:ansible/ansible
yes | sudo apt install ansible


# Trivy Scanner Installation
echo '--- Trivy Scanner Tool Installation ---'
yes | sudo apt-get install wget apt-transport-https gnupg
yes | wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
yes | sudo apt-get update
yes | sudo apt-get install trivy

# Installing AWS CLI
yes | sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# installing kubectl 

yes | sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
yes | sudo apt-get install apt-transport-https ca-certificates curl gnupg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
yes | sudo apt-get update
yes | sudo apt-get install kubectl


# docker installation
echo '--- Docker and Compose Installation ---'
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

# checkout the CICD Repo to local 
echo '--- Checkout the cicd-tasks-app git repo to local --'
sudo mkdir /opt/SP
cd /opt/SP ; git clone https://github.com/eswarmaganti/cicd-tasks-app.git
sudo chown -R ubuntu: /opt/SP

# change the permissions for private key
echo '--- Modifying the privatekey file permissions ---'
sudo chmod 400 /home/ubuntu/.ssh/dev_ec2
sudo cp /home/ubuntu/.ssh/dev_ec2 /var/lib/jenkins/.ssh/
sudo chown jenkins: /var/lib/jenkins/.ssh/dev_ec2
yes | sudo reboot