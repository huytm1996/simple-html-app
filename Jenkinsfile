pipeline {
    agent none

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'huytm1996/html-app'
    }

    stages {
        stage('Checkout') {
            agent any
            steps {
                git branch: 'main', url: 'https://github.com/huytm1996/simple-html-app.git'
            }
        }

        stage('Build & Push Docker Image') {
            agent { docker { image 'docker:24.0.5' args '-u root -v /var/run/docker.sock:/var/run/docker.sock' } }
            steps {
                sh '''
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                docker build -t $DOCKER_IMAGE:latest .
                docker push $DOCKER_IMAGE:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            agent { docker { image 'bitnami/kubectl:latest' args '-u root' } }
            steps {
                sh '''
                kubectl set image deployment/html-app html-app=$DOCKER_IMAGE:latest --record
                kubectl rollout status deployment/html-app
                '''
            }
        }
    }

    triggers {
        githubPush()
    }
}
