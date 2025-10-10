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
              sh docker build -t saigowtham2605/financeme1:1.0 .
                  }
                }
}
}
