data "terraform_remote_state" "calc_remote_state" {
  backend = "s3"
  config {
    bucket = "calc-sr-tfstate-${var.env}-core"
    region = "eu-west-1"
    key = "calc-${var.env}.tfstate"
  }
}
