node {
    stage 'build-test-hello'
    //this triggers the Jenkins job that builds the container
    //build 'test-svc'

    stage 'Publish containers'
    shouldPublish = input message: 'Publish Containers?', parameters: [[$class: 'ChoiceParameterDefinition', choices: 'yes\nno', description: '', name: 'Deploy']]
    if(shouldPublish == "yes") {
     echo "Publishing docker containers"
     sh "\$(aws ecr get-login)"

     sh "docker tag demo/hello_app:8 789391878624.dkr.ecr.eu-west-1.amazonaws.com/hello_world:latest"
     sh "docker push 789391878624.dkr.ecr.eu-west-1.amazonaws.com/hello_world:latest"
    }
}
