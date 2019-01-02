terraform {
  backend "s3" {}

  required_version = "= 0.11.10"
}

provider "aws" {
  version = "1.16.0"
  region = "eu-west-1"
}
