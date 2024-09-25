pipeline {
    agent any
    stages{
        stage('build project'){
            steps{
                git url:'https://github.com/pranali-sawant20/FinanceMe-Microservice-Project.git', branch: "master"
                sh 'mvn clean package'
              
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t pranalisawant/staragileprojectfinance:v1 .'
                    sh 'docker images'
                }
            }
        }
         
        
     stage('Deploy') {
            steps {
                sh 'sudo docker run -itd --name My-first-containe01 -p 8083:8081 pranalisawant/staragileprojectfinance:v1'
                  
                }
            }
        
    }
}
