pipeline {
    agent { label 'local' }
    stages {
       stage('build') {
          steps {
          sh 'dockerbuild.sh'
                echo 'Multiline'
                echo 'hello'
             '''
             echo 'not using shell'
          }
       }
    }
}
