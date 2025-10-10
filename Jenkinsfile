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
      stage('Docker Login & Push') {
  steps {
    withCredentials([usernamePassword(
      credentialsId: 'gowsaicred1',
      usernameVariable: 'DOCKER_USER',
      passwordVariable: 'DOCKER_PAT'
    )]) {
      sh '''
        set -e
        echo "Logging into Docker Hub as $DOCKER_USER (non-interactive)"
        echo "$DOCKER_PAT" | docker login -u "$DOCKER_USER" --password-stdin

        echo "Pushing image..."
        docker push saigowtham2605/financeme1:1.0

        docker logout || true
      '''
    }
  }
}
 }
}  
