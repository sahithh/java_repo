pipeline {
    agent any
tools {
  maven 'MAVEN-3.9'
}
    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/SOHAN-cyber/java-repo.git'
            }
        }
        stage ('Building Docker Image') {
            steps {
                sh 'docker build -t dogra21703/java_code:latest .'
                sh 'docker image tag dogra21703/java_code:latest dogra21703/java_code:${BUILD_NUMBER}'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: '10', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker push dogra21703/java_code:latest'
                    sh 'docker push dogra21703/java_code:${BUILD_NUMBER}'
}
            }
        }
        stage('Notfication to approve the pipeline') {
            steps{
            mail to: 'sohandogra703@gmail.com',
            subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) is waiting for input",
            body: "Please go to ${BUILD_URL} and Approve the build"

            }
        }
        stage ('Approval Stage') {
            input {
               message "Do you want to proceed for production deployment?"
            }
            steps {
                sh 'echo done'
            }
        }
        stage ('Deploy to Kubernetes') {
            steps {
            sh 'export BUILD_NUMBER=${BUILD_NUMBER}'
            sh 'echo $BUILD_NUMBER'
            sh  'envsubst < deployment.yaml  | kubectl apply -f -'
            }
        }
    }
    post {
        always {
            cleanWs()
            emailext attachLog: true, body: "Jenkins Pipeline '${JOB_NAME}' is over .. Build #${BUILD_NUMBER}.. and Build status is.. ${currentBuild.result}. To check result of build click on url ${BUILD_URL}", compressLog: true, recipientProviders: [buildUser()], replyTo: 'sohandogra703@gmail.com', subject: "Jenkins Job:${JOB_NAME} is over .. and is.. ${currentBuild.result}.", to: 'sohandogra703@gmail.com'
        }
    }
}