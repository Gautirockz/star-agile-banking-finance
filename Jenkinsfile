pipeline {
    agent any
 stages {
        stage('Build') {
            steps {
               // Get some code from a GitHub repository
              git url: 'https://github.com/Gautirockz/star-agile-banking-finance.git', branch: 'master'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

            }        
        }
  stage('Create Docker Image') {
           steps {
              sh 'docker build -t saigowtham2605/financeme1:1.0 .'

                  }
                }
       stage('Docker-Login') {
           steps {
         withCredentials([usernamePassword(credentialsId: 'gowsaicred1', passwordVariable: 'gowpass', usernameVariable: 'gowdocker')]) {
               //withCredentials([usernameColonPassword(credentialsId: 'dockercred1', variable: 'dockerlogin')]) {
                //withCredentials([file(credentialsId: 'gowtham123', variable: 'gowtham1')]) { 
    sh 'docker login -u saigowtham2605'
     }
              }
       }
        stage('Push-Image') {
           steps {
               sh 'docker push saigowtham2605/financeme1:1:0'
                     }
                }
}
}
