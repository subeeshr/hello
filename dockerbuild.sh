#!/bin/bash

set -ex

export PATH="$PATH:/usr/local/bin"
export AWS_PROFILE=admin
cd ~/hello
PARENT_DIR=$(basename "${PWD%/*}")
CURRENT_DIR="${PWD##*/}"
IMAGE_NAME="$PARENT_DIR"_"$CURRENT_DIR"
#TAG="${1}"
CMD=`aws ecr get-login --no-include-email --region eu-west-1`
REGISTRY="789391878624.dkr.ecr.eu-west-1.amazonaws.com"
$CMD
docker build -t ${REGISTRY}/${IMAGE_NAME} .
docker tag ${REGISTRY}/${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}:latest
docker push ${REGISTRY}/${IMAGE_NAME}
