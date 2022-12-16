pipeline {
    agent any
tools {
  maven 'maven3.8.6'
}

options {
    timestamps()
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
}


    stages {
        stage('checkout code') {
            steps {
                git branch: '${BranchName}', credentialsId: 'GitHub', url: 'https://github.com/yellaiah56/sample-hello-world-app.git'
            }
        }
        stage('code build'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('build image'){
             when {
         expression{
              //return env.GIT_BRANCH == "origin/prod"
           return "${BranchName}" == "origin/prod"
                   }
            }
        
            
            steps{
                sh "docker build -t yellaiah56/helloworld:${env.BUILD_NUMBER} ."
            }
        }
        stage('docker login'){
            steps{
                 withCredentials([string(credentialsId: 'dockerhub_pwd', variable: 'password')]){
                sh "docker login -u yellaiah56 -p ${password}"
            }
            }
        }
        
        stage('push image'){
             when {
         expression{
              //return env.GIT_BRANCH == "origin/prod"
           return "${BranchName}" == "origin/prod"
                   }
            }
           
            steps{
                
          sh "docker push yellaiah56/helloworld:${env.BUILD_NUMBER} "
}
            }
        stage("container cleanup"){
             when {
         expression{
              //return env.GIT_BRANCH == "origin/prod"
           return "${BranchName}" == "origin/prod"
                   }
            }
            steps{
                sh "docker rm -f webapp || true"
            }
        }
        stage('deploy container'){
            
            when {
         expression{
          //  return env.GIT_BRANCH == "origin/prod"
          return "${BranchName}" == "origin/prod"
                   }
            }
            
            steps{
                sh "docker run -d --name webapp -p 9090:8080 yellaiah56/helloworld:${env.BUILD_NUMBER}"
            }
        }
        stage('image clean up'){
            steps{
                sh "docker image prune -af"
            }
        }
    }//stage end
    
}//pipeline end
