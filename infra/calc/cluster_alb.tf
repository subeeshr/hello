resource "aws_alb" "calc_alb" {
  name            = "calc-${var.env}-${var.cluster_name}"
  internal        = true
  security_groups = ["${aws_security_group.alb_sg.id}"]
  subnets         = ["${aws_subnet.calc_cluster_subnet_a.id}","${aws_subnet.calc_cluster_subnet_b.id}"]

  enable_deletion_protection = false
#  access_logs {
#  bucket = "calc-terraform-uk-alb-logs-${var.env}"
#    enabled = false
#  }
}
