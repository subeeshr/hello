output "alb_dns_name" {
  value = "${aws_alb.calc_alb.dns_name}"
}
output "alb_zone_id" {
  value = "${aws_alb.calc_alb.zone_id}"
}
output "alb_arn" {
  value = "${aws_alb.calc_alb.arn}"
}
output "alb_sg" {
  value = "${aws_security_group.alb_sg.id}"
}
output "service_sg" {
  value = "${aws_security_group.service_sg.id}"
}
output "calc_cluster_subnet_a" { value = "${aws_subnet.calc_cluster_subnet_a.id}" }

output "calc_cluster_subnet_b" { value = "${aws_subnet.calc_cluster_subnet_b.id}" }

output "ecs_service_role" {
  value = "${aws_iam_role.ecs_service.name}"
}
output "ecs_app_instance_profile" {
  value = "${aws_iam_instance_profile.app.name}"
}
output "ecs_app_autoscale_role" {
  value = "${aws_iam_role.ecs_autoscale.arn}"
}
output "kms_calc" { value = "${data.aws_kms_alias.calc_kms_chamber_alias.target_key_arn}"}
