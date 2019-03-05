pipeline {
  agent { dockerfile true }
  
  triggers {
        pollSCM('*/5 * * * 1-5')
    }
  options {
    skipDefaultCheckout(true)
    // Keep the 10 most recent builds
    buildDiscarder(logRotator(numToKeepStr: '10'))
    timestamps()
  }
  environment {
    registry = "almeidalopes/bokeh-visualizations"
    registryCredential = 'docker-hub-credentials'
  }
  
  stages {
    stage('Build') {
      steps {
        checkout scm
      }
    }
    stage('Build image') {
      steps{
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Test') {
      steps {
        echo 'Testing...'
      }
    }
  }
  post {
    always {
      echo 'This will always run'

    }

    success {
      echo 'This will run only if successful'

    }

    failure {
      echo 'This will run only if failed'

    }

    unstable {
      echo 'This will run only if the run was marked as unstable'

    }

    changed {
      echo 'This will run only if the state of the Pipeline has changed'
      echo 'For example, if the Pipeline was previously failing but is now successful'

    }

  }
}
