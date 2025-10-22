pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'huytm1996/html-app'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                docker build -t $DOCKER_IMAGE:latest .
                docker push $DOCKER_IMAGE:latest
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                kubectl set image deployment/html-app html-app=$DOCKER_IMAGE:latest --record
                kubectl rollout status deployment/html-app
                '''
            }
        }
    }
}
