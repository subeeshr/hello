pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'set -ex'
                sh 'export PATH="$PATH:/usr/local/bin"'
                sh 'export AWS_PROFILE=admin'
                sh 'cd ~/hello'
                sh 'IMAGE_NAME=new_repo'
                sh 'REGISTRY="789391878624.dkr.ecr.eu-west-1.amazonaws.com"'
                sh 'CMD=`/usr/local/bin/ aws ecr get-login --no-include-email --region eu-west-1`'
                sh '$CMD'
                sh '/usr/local/bin/ docker build -t ${REGISTRY}/${IMAGE_NAME}:to_tag .'
                sh '/usr/local/bin/ docker tag ${REGISTRY}/${IMAGE_NAME}:to_tag ${REGISTRY}/${IMAGE_NAME}:latest'
                sh '/usr/local/bin/ docker push ${REGISTRY}/${IMAGE_NAME}:latest'
                sh '''
                    echo "Multiline shell steps works too"
                    ls -lah
                '''
            }
        }
    }
}
