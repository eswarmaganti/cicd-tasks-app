pipeline{
    environment{
        GIT_REPO_URL: 'https://github.com/eswarmaganti/mern-tasks-app.git'
    }
    stages{
        stage('Pull Docker Images'){
            script{
                sh 'docker pull eswarmaganti/react-tasks-app:latest'
                sh 'docker pull eswarmaganti/node-tasks-app:latest'
            }
        }
    }
}