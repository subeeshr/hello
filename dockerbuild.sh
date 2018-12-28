#!/bin/bash

set -ex

export PATH="$PATH:/usr/local/bin"
export AWS_PROFILE=admin
cd ~/hello
#PARENT_DIR=$(basename "${PWD%/*}")
#CURRENT_DIR="${PWD##*/}"
IMAGE_NAME=new_repo
REGISTRY="789391878624.dkr.ecr.eu-west-1.amazonaws.com"
#TAG="${1}"
CMD=`aws ecr get-login --no-include-email --region eu-west-1`
$CMD
docker build -t ${REGISTRY}/${IMAGE_NAME}:to_tag .
docker tag ${REGISTRY}/${IMAGE_NAME}:to_tag ${REGISTRY}/${IMAGE_NAME}:latest
docker push ${REGISTRY}/${IMAGE_NAME}:latest
