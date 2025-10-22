pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'huytm1996/html-app'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir() // luôn xoá sạch workspace trước mỗi build
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/huytm1996/simple-html-app.git'
            }
        }

        stage('Build Docker Image') {
            agent {
                docker {
                    image 'docker:25.0.3-dind'
                    args "-v /var/run/docker.sock:/var/run/docker.sock -v ${env.WORKSPACE}:${env.WORKSPACE} -w ${env.WORKSPACE}"
                }
            }
            steps {
                sh 'ls -la' // Kiểm tra code có thật
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Push to Docker Hub') {
            agent {
                docker {
                    image 'docker:25.0.3-dind'
                    args "-v /var/run/docker.sock:/var/run/docker.sock -v ${env.WORKSPACE}:${env.WORKSPACE} -w ${env.WORKSPACE}"
                }
            }
            steps {
                sh '''
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                docker push $DOCKER_IMAGE:latest
                '''
            }
        }
    }
}
