resource "aws_alb_listener" "calc_alb_listener" {
  load_balancer_arn = "${aws_alb.calc_alb.arn}"
  port              = "${var.service_port}"
  protocol          = "${var.service_protocol}"
  default_action {
    target_group_arn = "${aws_alb_target_group.service_target_group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "service_target_group" {
  name        = "${var.env}-${var.service_name}"
  port        = "${var.service_port}"
  protocol    = "${var.service_protocol}"
  vpc_id      = "${aws_vpc.calc.id}"
  target_type = "ip"

  health_check {
    interval            = 10
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "${var.service_protocol}"
    path                = "${var.service_health_url}"
    matcher             = "${var.service_health_status_code}"
  }

}
