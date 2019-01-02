data "aws_caller_identity" "me" {}

data "template_file" "task_definition" {
  template = "${file("${path.module}/../services/${var.service_name}.json")}"}

resource "aws_ecs_task_definition" "app" {
  family                = "calc_${var.env}_${var.service_name}"
  container_definitions = "${data.template_file.task_definition.rendered}"
  task_role_arn         = "arn:aws:iam::${data.aws_caller_identity.me.account_id}:role/calc_app_instance_iam_role_dev"
  network_mode          = "awsvpc"
}

resource "aws_ecs_service" "app" {
  name            = "calc_${var.env}_${var.service_name}"
  cluster         = "calc_${var.env}_${var.cluster_name}"
  task_definition = "${aws_ecs_task_definition.app.arn}"
  desired_count   = "${var.service_desired}"
  health_check_grace_period_seconds = 90

  load_balancer {
    target_group_arn = "${aws_alb_target_group.service_target_group.arn}"
    container_name   = "${var.service_name}"
    container_port   = "${var.service_port}"
  }

  network_configuration {
    subnets = ["${aws_subnet.calc_cluster_subnet_a.id}","${aws_subnet.calc_cluster_subnet_b.id}"]
    security_groups = ["${aws_security_group.service_sg.id}", "${aws_security_group.calc_base_container_sg.id}"]
  }

  depends_on = ["aws_ecs_task_definition.app", "aws_alb_listener.calc_alb_listener"]

}
