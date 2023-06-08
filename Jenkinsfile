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
        stage('Building Docker Image'){
            steps{
                sh 'docker build -t sahithh/java_code:latest .'
                sh 'docker image tag sahithh/java_code:latest docker push sahithh/java_code:${BUILD_NUMBER}'
            }
        }
        stage('Push Docker Image'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker push sahithh/java_code:${BUILD_ID}'
                    sh 'docker push sahithh/java_code:latest'
                } 
                
            }
        }
        stage('Deploy to EC2'){
            steps{
                sh 'echo done'
            }
        }
    }
    post{
        always{
            cleanWs()
        }
    }
}
