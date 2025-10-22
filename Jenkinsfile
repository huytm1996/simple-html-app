pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'huytm1996/html-app'
    }

    stages {
        // ✅ Để plugin Git tự checkout (trên Jenkins host)
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/huytm1996/simple-html-app.git'
            }
        }

        // ✅ Các stage sau mount workspace để thấy code
        stage('Build Docker Image') {
            agent {
                docker {
                    image 'docker:25.0.3-dind'
                    args "-v /var/run/docker.sock:/var/run/docker.sock -v ${env.WORKSPACE}:${env.WORKSPACE} -w ${env.WORKSPACE}"
                }
            }
            steps {
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

        stage('Deploy to Kubernetes') {
            agent {
                docker {
                    image 'bitnami/kubectl:latest'
                    args "-u root -v ${env.HOME}/.kube:/root/.kube -v ${env.WORKSPACE}:${env.WORKSPACE} -w ${env.WORKSPACE}"
                }
            }
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
