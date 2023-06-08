pipeline{
    agent any
    tool{
        maven 'maven'
    }
    stages{
        stage('Clone') {
            steps{
                git 'https://github.com/sahithh/java_repo.git'
            }
        }
        stage('Build'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Deploy to EC2'){
            steps{
                sh 'ansible playbook -i host ec2-deployment.yaml'
            }
        }
    }
    post{
        always{
            cleanWs()
        }
    }
}