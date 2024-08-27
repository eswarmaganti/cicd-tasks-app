pipeline{
    agent any
    tools {nodejs "node"}
    stages{
        stage('Checkout'){
            steps{
                git url: 'https://github.com/eswarmaganti/mern-tasks-app.git', branch: 'main'
            }
        }
        stage('Sonar Scan'){
            environment{
                scannerHome = tool 'SonarQubeScanner'
            }
            steps{
                withSonarQubeEnv('SonarQubeServer'){
                    sh '${scannerHome}/bin/sonar-scanner --version'
                    sh '${scannerHome}/bin/sonar-scanner '
                }
            }
        }
    }
}