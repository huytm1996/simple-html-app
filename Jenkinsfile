pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'huytm1996/html-app'
    }

    stages {
        stage('Checkout') {
            steps {
              checkout scm
              script {
                    env.GIT_COMMIT = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                }
              cleanWs() // dọn workspace cũ
              
               
            }
        }
    

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh '''
                              
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                docker push $DOCKER_IMAGE:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh ''' 
                  # Áp dụng manifest để tạo (nếu chưa có)
                kubectl apply -f deployment.yaml
                kubectl set image deployment/html-app html-app=$DOCKER_IMAGE:latest --record
                kubectl rollout restart deployment/html-app
                kubectl rollout status deployment/html-app
                '''
            }
        }
        stage('Save Artifact') {
            steps {
               script {
                 env.BUILD_TAG =  "huytm1996/html-app.v${env.BUILD_NUMBER}"
                 sh """
                 echo "Build Number: ${env.DOCKER_IMAGE}" > build-info.txt
                 echo "Git Commit: ${GIT_COMMIT}" >> build-info.txt
                 echo "Tag: ${BUILD_TAG}" >> build-info.txt
                 echo "Date: $(date)" >> build-info.txt
                 """
            archiveArtifacts artifacts: 'build-info.txt', onlyIfSuccessful: true
                       }
                  }
                              }

    }

    triggers {
       
        githubPush()
    }
}
