resource "aws_security_group" "calc_base_container_sg" {
  description = "attached to all container services, base rules"
  name = "calc_${var.env}_base_container"
  tags {
    env = "${var.env}"
    terraform = "true"
  }
  vpc_id = "${aws_vpc.calc.id}"
}

resource "aws_security_group" "service_sg" {
  name = "calc_${var.env}_${var.cluster_name}_${var.service_name}"
  tags {
    env = "${var.env}"
    terraform = "true"
  }
  vpc_id = "${aws_vpc.calc.id}"
}

resource "aws_security_group_rule" "service_allow_alb_incoming" {
  description = "${var.cluster_name} ALB in to ${var.service_name}"
  security_group_id = "${aws_security_group.service_sg.id}"

  type = "ingress"
  from_port = "${var.service_port}"
  to_port = "${var.service_port}"
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.alb_sg.id}"
}

resource "aws_security_group_rule" "service_allow_alb_outgoing" {
  description = "${var.cluster_name} ALB out to ${var.service_name}"
  security_group_id = "${aws_security_group.alb_sg.id}"

  type = "egress"
  from_port = "${var.service_port}"
  to_port = "${var.service_port}"
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.service_sg.id}"
}
