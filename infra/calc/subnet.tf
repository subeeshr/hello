resource "aws_subnet" "calc_cluster_subnet_a" {
  #count                   = 2
  vpc_id                  = "${aws_vpc.calc.id}"
  #cidr_block              = "${var.calc_subnet_base}.${element(var.suffixes_calc, count.index)}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = false
  #availability_zone       = "${element(var.aws_azs, count.index)}"
  availability_zone       = "eu-west-1a"
  tags {
    Name = "calc_${var.env}_cluter_subneta"
    env = "${var.env}"
    terraform = "true"
  }
}
resource "aws_subnet" "calc_cluster_subnet_b" {
  #count                   = 2
  vpc_id                  = "${aws_vpc.calc.id}"
  #cidr_block              = "${var.calc_subnet_base}.${element(var.suffixes_calc, count.index)}"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
  #availability_zone       = "${element(var.aws_azs, count.index)}"
  availability_zone       = "eu-west-1b"
  tags {
    Name = "calc_${var.env}_cluter_subnetb"
    env = "${var.env}"
    terraform = "true"
  }
}
