# Required for chamber secret store https://github.com/segmentio/chamber

resource "aws_kms_key" "calc_kms_chamber" {
  description             = "calc_${var.env}_chamber"
  enable_key_rotation     = true
  tags {
    Name = "calc_${var.env}_chamber"
    env = "${var.env}"
    terraform = "true"
  }
}

resource "aws_kms_alias" "calc_kms_chamber_alias" {
  name          = "alias/calc_${var.env}_chamber"
  target_key_id = "${aws_kms_key.calc_kms_chamber.id}"
}
