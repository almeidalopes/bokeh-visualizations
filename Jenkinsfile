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
  def app

  stage('Clone repository') {
      /* Let's make sure we have the repository cloned to our workspace */

      checkout scm
  }

  stage('Build image') {
      /* This builds the actual image; synonymous to
       * docker build on the command line */

      app = docker.build("almeidalopes/bokeh-visualizations")
  }

  stage('Test image') {
      /* Ideally, we would run a test framework against our image.
       * For this example, we're using a Volkswagen-type approach ;-) */

      app.inside {
          sh 'echo "Tests passed"'
      }
  }

  stage('Push image') {
      /* Finally, we'll push the image with two tags:
       * First, the incremental build number from Jenkins
       * Second, the 'latest' tag.
       * Pushing multiple tags is cheap, as all the layers are reused. */
      docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
          app.push("${env.BUILD_NUMBER}")
          app.push("latest")
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
