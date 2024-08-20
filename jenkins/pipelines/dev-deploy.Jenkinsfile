pipeline{
    environment{
        GIT_REPO_URL: 'https://github.com/eswarmaganti/mern-tasks-app.git'
        SCRIPT_PATH: '/opt/SP/cicd-tasks-app/deployments/dev/src/main.py'
    }
    stages{
        stage('Deploy'){
            steps{
                script{
                    sh 'usr/bin/python3 ${SCRIPT_PATH}'
                }
                post{
                    success{
                        echo "Deployment is successful"
                    }
                    unsuccessful{
                        echo "Deployment is failed"       
                    }
                }
            }
        }
    }
    
}