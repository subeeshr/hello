## IAM

resource "aws_iam_role" "ecs_service" {
  name = "calc_service_iam_role_${var.env}"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "ecs_autoscale" {
  name = "calc_autoscale_ecs_assume_role_${var.env}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "ecs_service" {
  name = "calc_service_iam_role_policy_${var.env}"
  role = "${aws_iam_role.ecs_service.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:Describe*",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:RegisterTargets"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "app" {
  name  = "calc_app_iam_instance_profile_${var.env}"
  role = "${aws_iam_role.app_instance.name}"
}

resource "aws_iam_role" "app_instance" {
  name = "calc_app_instance_iam_role_${var.env}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "template_file" "instance_profile" {
  template = "${file("instance-profile-policy.json")}"
}

data "template_file" "autoscaling_json" {
  template = "${file("autoscaling_policy.json")}"
}

resource "aws_iam_role_policy" "instance" {
  name   = "calc_instance_iam_role_policy_${var.env}"
  role   = "${aws_iam_role.app_instance.name}"
  policy = "${data.template_file.instance_profile.rendered}"
}


resource "aws_iam_role_policy" "autoscaling" {
  name = "calc_autoscaling_ecs_iam_role_policy_${var.env}"
  role = "${aws_iam_role.ecs_autoscale.name}"
  policy = "${data.template_file.autoscaling_json.rendered}"
}
