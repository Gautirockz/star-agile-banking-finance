pipeline {
  agent any

  stages {

    stage('Build') {
      steps {
        git url: 'https://github.com/Gautirockz/star-agile-banking-finance.git', branch: 'master'
        sh 'mvn -Dmaven.test.failure.ignore=true clean package'
      }
    }

    stage('Create Docker Image') {
      steps {
        sh 'docker build -t saigowtham2605/financeme1:1.0 .'
      }
    }

    stage('Docker Login & Push') {
      steps {
        withCredentials([
          usernamePassword(
            credentialsId: 'gowsaicred1',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PAT'
          )
        ]) {
          sh '''
            set -e
            echo "$DOCKER_PAT" | docker login -u "$DOCKER_USER" --password-stdin
            docker push saigowtham2605/financeme1:1.0
            docker logout || true
          '''
        }
      }
    }

    stage('Config & Deployment') {
      steps {
        withCredentials([
          aws(
            accessKeyVariable: 'AWS_ACCESS_KEY_ID1',
            credentialsId: 'awsid1',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY1'
          ),
          sshUserPrivateKey(
            credentialsId: 'saijenkins1',
            keyFileVariable: 'PEM'
          )
        ]) {
          sh '''
            cp "$PEM" mykey.pem
            chmod 600 mykey.pem
            aws sts get-caller-identity --region ap-south-1 || true
            terraform init
            terraform validate
            terraform apply --auto-approve
          '''
        }
      }
    }
  }
}
