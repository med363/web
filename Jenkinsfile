@Library('Bah27-share-library')

pipeline{
  environment {
    IMAGE_NAME = "webapp2"
    IMAGE_TAG = "v2"
    STAGING = "med-staging'
    PRDUCTION = "med-production"
  }
  agent none
  stages {
    stage('Build image') {
      agent any
      steps {
        script {
          sh 'docker build -t mohamedamineblibech/$IMAGE_NAME/$IMAGE_TAG .
        }
      }
    }
    stage('Run container based on builded image') {
      agent any
      steps {
        script {
          sh '''
             docker run --name $IMAGE_NAME -d -p 80:5000 -e PORT=5000 mohamedamineblibech/$IMAGE_NAME:IMAGE8TAG
             sleep 5
         '''
        }
      }
    }
    stage("Clean container') {
          agent any 
          steps {
            script {
              '''
              docker stop $IMAGE_NAME
              docker rm $IMAGE_NAME
              '''
            }
          }
          }
          stage('Push image in staging and deploy it'){
            when {
              expression { GIT_BRANCH == 'origin/main' }
            }
            agent any
            environment {
              MED_API_KEY = credentials('med_api_key')
            }
            steps {
              script {
                '''
                med container:login
                med create $STAGING || echo "projects already exist"
                med container:push -a $STAGING wedapp
                med container:release -a $STAGING webapp
                '''
              }
            }
          }
          stage('Push image in production and deploy it'){
            when {
              expression { GIT_BRANCH == 'origin/main' }
            }
            agent any
            environment {
              MED_API_KEY = credentials('med_api_key')
            }
            steps {
              script {
                '''
                med container:login
                med create $PRODUCTION || echo "projects already exist"
                med container:push -a $PRODUCTION wedapp
                med container:release -a $PRODUCTION webapp
                '''
              }
            }
          }
          }
          post {
            always {
              script {
                stackNotifier currentBuild.result
              }
            }
          }
          }
          
