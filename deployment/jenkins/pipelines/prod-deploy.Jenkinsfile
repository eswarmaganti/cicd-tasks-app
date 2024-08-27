pipeline{
    agent any
    environment{
        GIT_REPO_URL= 'https://github.com/eswarmaganti/mern-tasks-app.git'
        SCRIPT_PATH= 'deployment/scripts/src/main.py'
        ENVIRONMENT = "prod"
    }
    tools {nodejs 'node'}
    stages{
        stage('Jenkins Environment'){
            steps{
                sh "echo '--- Jenkins Environment Versions ---'"
                sh 'python3 --version'
                sh 'java --version'
                sh 'ansible --version'
                sh 'docker --version'
                sh 'node --version'
                sh 'git --version'
            }
        }
        stage('Code Checkout'){
            steps{
                sh "echo '--- Code Checkout ---'"
                git url:'https://github.com/eswarmaganti/cicd-tasks-app.git',branch:'main'
            }
        }
        stage('DEV Deployment'){
            steps{
                script{
                    sh "echo '--- Deployment Script Triggered ---'"
                    sh '/usr/bin/python3 ${SCRIPT_PATH} ${ENVIRONMENT}'
                }
            }
        }

        stage('Post Deployment Check'){
            steps{
                sh "kubectl get deployments"
                sh "kubectl get rs"
                sh "kubectl get pods"
                sh "kubectl get svc"
            }
        }
    }

        post{
            success{
                echo "Deployment is successful"
            }
            failure{
                echo "Deployment is failed"       
            }
        }
    
}