pipeline{
    agent any
    tools{
        maven 'maven'
    }
    stages{
        stage('Clone') {
            steps{
                git branch: 'main', url: 'https://github.com/sahithh/java_repo.git'
            }
        }
        stage('Build'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Deploy to EC2'){
            steps{
                sh 'ansiblePlaybook becomeUser: null, credentialsId: 'tomcat_privatekey', disableHostKeyChecking: true, installation: 'ansible', inventory: 'host', playbook: 'ec2-deployment.yaml'
            }
        }
    }
    post{
        always{
            cleanWs()
        }
    }
}
