# Introduction

This repo is used to deploy MERN Stack Tasks App using Jenkins as CICD Tool to deploy the application to multiple envirnments like Development environment using 3tier VPC architecture and Production environment using AWS EKS cluster.

# MERN Stack Tasks Application

- github repository url: https://github.com/eswarmaganti/mern-tasks-app.git
- In project, the frontend is created using React.JS javascript library, for backend integraion is implemented using node with express.js and to store the data the NoSQL MongoDB database system is used.
- The entire Tasks application is containerized using docker containerization tool and published the images to docker hub.
- To run the application in local system using docker, clone the repo using abobe url and run the application using `docker compose up` command in root directory of the project.

# Deploying AWS Infrastructure using Terraform

- The entire Infra for hosting this application is created using terraform IaC tool.
- The Infra creation is implemented using custom modules for each AWS component.
- The source code of terraform manifests are present in `terraform` directory in this github repository
- To create the infra using terraform, first you have to install terraform & awscli and configure your credentials in your system.
- Run the terraform manifeste using the below commands in `terraform > manifests` directory
  - `terraform init` to initialize the modules
  - `terraform validate` to validate the configuration
  - `terraform plan` to view the detailed plan about the infra to be created
  - `terraform apply -auto-approve` to provision the infrastrucutre
  - `terraform destroy -auto-approve` to destroy the provisioned infrastructure

# Continuous Integration (CI) using Jenkins Pipeline

- The CI part is implemented using jenkins tool which is installed and configured with all the necessary tools like java, python, terraform, ansible, docker, etc.
- For building the application, I have created a Jenkins file to checkout the sourcecode from github and build the application using docker.
- The build pipeline consists of multiple stage each stage have a particular significance in building the application
- I have integrated the static code analysis of the entire application using sonarqube tool. the sonarqube server will also running as a docker container inside the jenkins server.
- I have also integrated the docker image scanning using trivy to analyse the docker images for security issues and vulnerabilities
- once all the stages are successfully completed the docker images which are build using docker cli will be pushed to dockerhub.
- For building the application, the Jenkinsfile in the `deployment/jenkins/pipelines/build.Jenkinsfile` path is used.

# Continuous Delivery (CD) using Jenkins Pipeline

- For Delivering the application to multiple environments, I have configured ansible playbooks which can connects with multiple servers and deploys the application.
- The Deployment is done using a python script which will invoke a ansible playbook to deploy the application in Development and Production environments
- To Deploy the application in Development environment we can use the below command in project root directory
  - `python3 deployment/scripts/src/main.py dev deploy`
- We have to pass two command line arguments to the python script the first one is environment (dev/prod) the next one is action (deploy/rollback)
- In the simillar way to deploy the application to Production EKS Cluster, the below command is used
  - `python3 deployment/scripts/src/main.py prod deploy`
- To deploy the application to Development environment docker compose is used.
- To the deploy the application to Production environemnt (AWS EKS CLuster), kubectl tool is installed and configured with EKS Cluster using awscli.
- I have created two seperate Jenkinsfiles to create jenkins pipelines to deploy the application to Development and Production environments
  - `deployment/jenkins/pipelines/dev-deploy.Jenkinsfile` for DEV Deployment
  - `deployment/jenkins/pipelines/prod-deploy.Jenkinsfile` for PROD Deployment.
