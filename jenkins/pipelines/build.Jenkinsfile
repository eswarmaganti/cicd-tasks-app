pipeline{
    agent any
    environment{
        AWS_REGION = 'us-east-1'
        EKS_CLUSTER_NAME = 'eks-cluster'
        EKS_NAMESPACE = 'default'
        GIT_REPO_URL = 'https://github.com/eswarmaganti/mern-tasks-app.git'
        SONAR_SCANNER = 'SonarQubeScanner'
        SONAR_SERVER = 'SonarQubeServer'
    }
    tools{
        nodejs 'node'
    }

    stages{
        stage('Environment'){
            steps{
                sh echo '-- Environment Runtimes --'
                sh 'python3 --version'
                sh 'git --version'
                sh 'java --version'
                sh 'docker --version'
                sh 'ansible --version'
                sh 'node --version'
            }
        }

        stage('Code Checkout'){
            steps{
                echo '-- Code Checkout --'
                git url:GIT_REPO_URL, branch: 'main'
            }
        }

        stage('SonarQube Analysis'){
            environment{
                ScannerHome = tool SONAR_SCANNER;
            }
            steps{
                withSonarQubeEnv(SONAR_SERVER){
                    sh "echo '----- SonarQube Scanner Verison Details ------'"
                    sh '${ScannerHome}/bin/sonar-scanner --version'

                    sh "echi '-- Running Code Quality Analysis --'"
                    sh '${ScannerHome}/bin/sonar-scanner'
                }
            }
        }
        // stage('Sonar Quality Gate Check'){

        // }

        stage('Build'){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'dockerhub',usernameVariable:'dockerhub_username', passwordVariable:'dockerhub_password')]){
                        sh "echo '---- Building the Docker Images frontend react-tasks-app & backend node-tasks-app -----'"
                        sh 'echo ${dockerhub_password} | docker login -u  ${dockerhub_username} --password-stdin'
                        sh 'docker build -t eswarmaganti/react-tasks-app:latest ./react-client '
                        sh 'docker build -t eswarmaganti/node-tasks-app:latest ./tasks-api '
                    }
                }
                
            }
        }

        stage('Trivy Image Scan'){
            steps{
                sh "echo '-- Trivy Docker Image Scan --'"
                sh 'trivy image eswarmaganti/react-tasks-app:latest'
                sh 'trivy image eswarmaganti/react-tasks-app:latest'
            }
        }

        stage('Push Images to Docker Hub'){
            steps{
                script{
                        sh "echo '---- Pushing the Docker images to DockerHub ----'"
                        sh 'docker push eswarmaganti/react-tasks-app:latest'
                        sh 'docker push eswarmaganti/node-tasks-app:latest'
                    }
                    
                }
                
        }
    }

    post{
        success{
            echo "Build is Succeded"
        }
        failure{
            echo "Build is Failed"
        }
    }
}