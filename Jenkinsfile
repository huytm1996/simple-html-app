pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'huytm1996/html-app'
      
    }

    stages {
        stage('Checkout') {
            steps {
              cleanWs() // dọn workspace cũ
              git branch: 'main', url: 'https://github.com/huytm1996/simple-html-app.git'
               
            }
        }
    

        stage('Build Docker Image') {
            steps {
                sh '''
               
                docker build -t huytm1996/html-app:latest .
                

                '''
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
     
              kubectl apply -f deployment.yaml
             
           
         
                kubectl set image deployment/html-app   html-app=$DOCKER_IMAGE:latest 
            
          
                kubectl rollout status deployment/html-app
              
                '''
            }
        }
    }

    triggers {
       
        githubPush()
    }
}
