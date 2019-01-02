resource "aws_vpc" "calc" {
  cidr_block       = "${var.cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "calc-services"
  }
}
