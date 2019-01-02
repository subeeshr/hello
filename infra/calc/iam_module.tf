data "aws_kms_alias" "calc_kms_chamber_alias"                { name = "alias/calc_${var.env}_chamber" }

data "template_file" "iam_policy" {
  template = "${file("${path.module}/${var.iam_policy_filename}")}"
  vars {
    env = "${var.env}"
    service_name = "${var.service_name}"
    kms_chamber = "${aws_kms_key.calc_kms_chamber.arn}"
    kms_fles = "${data.aws_kms_alias.calc_kms_chamber_alias.target_key_arn}"
  }
}

resource "aws_iam_role" "iam_role" {

    name = "calc_${var.env}_${var.service_name}"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "calc" {

  name = "calc_${var.env}_${var.service_name}"
  role = "calc_${var.env}_${var.service_name}"
  depends_on = ["aws_iam_role.iam_role"]
  policy = "${data.template_file.iam_policy.rendered}"
}
