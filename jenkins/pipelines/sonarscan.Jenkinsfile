pipeline{
    agent any
    stages{
        stage('Checkout'){
            steps{
                git: url: 'https://github.com/eswarmaganti/mern-tasks-app.git', branch: 'main'
            }
        }
        stage('Sonar Scan'){
            environment{
                scannerHome = toll 'SonarQube'
            }
            withSonarQubeEnv('SonarQubeServer'){
                sh '${scannerHome}/bin/sonar-scanner --version'
                sh '${scannerHome}/bin/sonar-scanner ./'
            }
        }
    }
}