#!/bin/bash
set -euo pipefail

BUCKET_NAME="${1}"
BUCKET_VERSIONING="${2}"
command -v aws >/dev/null 2>&1 || { echo >&2 "MISSING DEPENDENCY: aws (from awscli package) not installed. Aborting."; exit 1; }

usage() {
  echo "ERROR! Invalid arguments. Usage:"
  echo ""
  echo "  $0 bucket-name-to-create (enable versioning: [true/false])"
  echo ""
  echo "  eg: $0 project-wa-tfstate-dev true"
  echo ""
}

if [[ ${BUCKET_VERSIONING} != "true" ]]; then
  if [[ ${BUCKET_VERSIONING} != "false" ]]; then
    usage
    exit 1
  fi
fi

echo "AWS_PROFILE is ${AWS_PROFILE}"
echo "BUCKET_NAME is ${BUCKET_NAME}"
echo "BUCKET_VERSIONING is ${BUCKET_VERSIONING}"
aws s3api create-bucket --acl private --region eu-west-1 \
  --bucket ${BUCKET_NAME} --create-bucket-configuration LocationConstraint=eu-west-1

if [[ ${BUCKET_VERSIONING} == "true" ]]; then
  echo -en "Enabling versioning on ${BUCKET_NAME}... "
  aws s3api put-bucket-versioning --region eu-west-2 \
  --bucket ${BUCKET_NAME} --versioning-configuration Status=Enabled && \
  echo "done"
fi

echo -en "Enabling s3-bucket-ssl-requests-only policy... "
aws s3api put-bucket-policy --bucket "${BUCKET_NAME}" \
  --policy "$(cat s3-bucket-ssl-requests-only.json | sed -e "s/BUCKET_NAME/${BUCKET_NAME}/g")" \
  && echo "done"
