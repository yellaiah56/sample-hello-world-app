pipeline {
    agent any
tools{
     maven 'maven3.8.6' 
  }
  
    stages {
        stage('checke out code'){
        steps{
        git branch: "${BranchName}", url: 'https://github.com/yellaiah56/sample-hello-world-app.git '
        }
      }
        stage('build'){
        steps{
        sh 'mvn clean package'
        }
        }
        stage('build image'){
        steps{
        sh "docker build -t yellaiah56/mavenapp:${env.BUILD_NUMBER} ."
        }
        }
        stage('login and push'){
        steps{ 
        sh 'docker login -u yellaiah56 -p Yellaiah@1211'
        sh "docker push yellaiah56/mavenapp:${env.BUILD_NUMBER}"
        }
        }
        stage('deploy'){
          when {
         expression{
            return env.GIT_BRANCH == "origin/prod"
                   }
            } 
        /*
        input{
           message "Do you want to deploy to production"
        }
        */
        steps{
        sh "docker rm -f javacontainer || true "
        sh "docker run --name javacontainer -p 9091:8080 yellaiah56/mavenapp:${env.BUILD_NUMBER} "
        }
        }
        }
        }
