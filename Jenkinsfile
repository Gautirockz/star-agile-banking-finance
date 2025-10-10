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
              // withCredentials([usernamePassword(credentialsId: 'saidockerid', passwordVariable: 'saipassword2', usernameVariable: 'saidocker2')]) { 
               //withCredentials([usernameColonPassword(credentialsId: 'dockercred1', variable: 'dockerlogin')]) {
               sh 'docker login -u saigowtham2605'
                   // withCredentials([string(credentialsId: '', variable: 'dockervariable')]) {
    // some block
                                    }
                                    }
                                    }
       stage('Push-Image') {
           steps {
               sh 'docker push docker push saigowtham2605/financeme1:1:0'
                     }
                }
}
}
