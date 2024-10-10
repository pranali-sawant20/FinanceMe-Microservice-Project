pipeline{
    agent any
    stages{
        stage('checkout the code from github'){
            steps{
                 git url: 'https://github.com/pranali-sawant20/FinanceMe-Microservice-Project.git'
                 echo 'github url checkout'
            }
        }
        stage('codecompile'){
            steps{
                echo 'starting compiling'
                sh 'mvn compile'
            }
        }
        stage('codetesting'){
            steps{
                sh 'mvn test'
            }
        }
        stage('qa'){
            steps{
                sh 'mvn checkstyle:checkstyle'
            }
        }
        stage('package'){
            steps{
                sh 'mvn package'
            }
        }
        stage('Create Docker Image') {
      steps {
        echo 'This stage will Create a Docker image'
        sh 'docker build -t pranalisawant/finance-me-microservice:1.0 .'
                          }
            }
     stage('Login to Dockerhub') {
      steps {
        echo 'This stage will loginto Dockerhub' 
        withCredentials([usernamePassword(credentialsId: 'dockerloginnew', passwordVariable: 'dockerpass', usernameVariable: 'dockeruser')]) {
        sh 'docker login -u ${dockeruser} -p ${dockerpass}'
            }
         }
     }
      stage('Docker Push-Image') {
      steps {
        echo 'This stage will push my new image to the dockerhub'
        sh 'docker push pranalisawant/finance-me-microservice:1.0'
            }
      }
        stage('aws_login'){
            withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awsaccess', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    // some block
}
        stage('Terraform Init') {
            steps {
                script {
                    sh '''
                    terraform workspace select test || terraform workspace new test
                    terraform init -input=false
                    '''
                }
            }
        }
        stage('Terraform Plan & Apply') {
            steps {
                script {
                    sh '''
                    terraform plan -out=tfplan -input=false
                    terraform apply -auto-approve tfplan
                    terraform output -raw instance_public_ip > instance_ip.txt
                    '''
                }
            }
        }
        stage('Terraform Operations for Production Workspace') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                script {
                    sh '''
                    terraform workspace select production || terraform workspace new production
                    terraform init -input=false

                    if terraform state show aws_key_pair.example 2>/dev/null; then
                        echo "Key pair already exists in the prod workspace"
                    else
                        terraform import aws_key_pair.example key02 || echo "Key pair already imported"
                    fi

                    terraform plan -out=tfplan -input=false
                    terraform apply -auto-approve tfplan
                    terraform output -raw instance_public_ip > instance_ip.txt
                    '''
                }
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                script {
                    def instanceIp = readFile('instance_ip.txt').trim()
                    sh """
                        ansible-playbook -i inventory.ini -e "prometheus_ip=${instanceIp}" ansible-playbook.yml
                    """
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
