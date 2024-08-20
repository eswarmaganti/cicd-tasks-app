pipeline{
    agent any
    environment{
        AWS_REGION = 'us-east-1'
        EKS_CLUSTER_NAME = 'eks-cluster'
        EKS_NAMESPACE = 'default'
        GIT_REPO_URL = 'https://github.com/eswarmaganti/mern-tasks-app.git'
    }

    stages{
        stage('CheckOut'){
            steps{
                git url:GIT_REPO_URL, branch: 'main'
            }
        }
        stage('Build'){
            steps{
                script{
                    sh 'docker build -t eswarmaganti/react-tasks-app:latest ./react-client '
                    sh 'docker build -t eswarmaganti/node-tasks-app:latest ./tasks-api '
                }
                
            }
        }
        stage('Push Images to Docker Hub'){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'dockerhub',usernameVariable:'dockerhub_username', passwordVariable:'dockerhub_password')]){
                        sh 'docker login -u  ${dockerhub_username} -p ${dockerhub_password}'
                        sh 'docker push --all-tags eswarmaganti/react-tasks-app'
                        sh 'docker push --all-tags eswarmaganti/node-tasks-app'
                    }
                    
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