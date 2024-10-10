pipeline {
    agent any
    stages {
        stage('Clone Git Repository') {
            steps {
                git 'https://github.com/pranali-sawant20/FinanceMe-Microservice-Project.git'
            }
        }
        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
