node {
  stage 'Checkout'
  git 'https://github.com/subeeshr/hello.git'

  stage 'Docker build'
  docker.build('hello')

  stage 'Docker push'
  docker.withRegistry('https://789391878624.dkr.ecr.eu-west-1.amazonaws.com', 'ecr:eu-west-1:demo-ecr-credentials') {
    docker.image('hello').push('latest')
  }
}
