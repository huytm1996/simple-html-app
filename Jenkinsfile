pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'huytm1996/html-app'
    }

    stages {
        stage('Checkout') {
            steps {
                credentialsId: 'github-cer',
                git branch: 'main', url: 'https://github.com/huytm1996/simple-html-app.git'
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
    }

    triggers {
       
        githubPush()
    }
}
