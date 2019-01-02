resource "aws_security_group" "alb_sg" {
  name = "calc_${var.env}_alb"
  tags {
    env = "${var.env}"
    terraform = "true"
  }
  vpc_id = "${aws_vpc.calc.id}"
}

resource "aws_security_group" "calc_base_instance_sg" {
  description = "attached to all instances, base rules"
  name = "calc_${var.env}_base_instance"
  tags {
    env = "${var.env}"
    terraform = "true"
  }
  vpc_id = "${aws_vpc.calc.id}"
}
