resource "aws_ecs_cluster" "app" {
  name = "calc_${var.env}_${var.cluster_name}"
}

resource "aws_autoscaling_group" "app" {
  name = "calc_${var.env}_${var.cluster_name}_asg_${aws_launch_configuration.app.name}"
  vpc_zone_identifier  = ["${aws_subnet.calc_cluster_subnet_a.id}"]
  min_size = "${var.asg_desired}"
  max_size = "${var.asg_desired + 1}"
  desired_capacity = "${var.asg_desired}"
  launch_configuration = "${aws_launch_configuration.app.name}"

  tag {
    key = "name"
    value = "calc-${var.env}-ecs-${var.cluster_name}"
    propagate_at_launch = true
  }
  tag {
    key = "env"
    value = "${var.env}"
    propagate_at_launch = true
  }
  tag {
    key = "terraform"
    value = "true"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "app" {

  security_groups = ["${aws_security_group.calc_base_instance_sg.id}"]
  key_name = "${var.ssh_key}"
  image_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  #iam_instance_profile = "${var.instance_iam_profile}"
  #user_data = "${data.template_file.userdata_ecs_cluster.rendered}"
  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }
}
