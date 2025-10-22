pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'huytm1996/html-app'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone code từ GitHub
              git branch: 'main',
            credentialsId: 'github-creds',
            url: 'https://github.com/huytm1996/simple-html-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh 'docker build -t $DOCKER_IMAGE:latest .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh '''
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                    docker push $DOCKER_IMAGE:latest
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                dir("${env.WORKSPACE}") {
                    sh '''
                    kubectl set image deployment/html-app html-app=$DOCKER_IMAGE:latest --record
                    kubectl rollout status deployment/html-app
                    '''
                }
            }
        }
    }

    triggers {
        githubPush()
    }
}
