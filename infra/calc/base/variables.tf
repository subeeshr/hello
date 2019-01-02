# Passed into module
variable "cidr" { default = "10.0.0.0/16" }
variable "env" { default = "dev"}
variable "cluster_name" { default = "calc" }
#variable "alb_subnet_ids" { type = "list" }
#variable "cluster_subnet_ids" { type = "list" }
#variable "cluster_base_sg" {}
variable "asg_desired" { default = "1" }
variable "ssh_key" { default = "calc"}
#variable "instance_iam_profile" {}
variable "instance_type" { default = "t2.micro" }
#variable "vpc_id" {}
#variable "alb_internal" {}
variable "ami_id" { default = "ami-08935252a36e25f85" }
#variable "alb_arn" {}
variable "service_port" { default = "8080"}
variable "service_protocol" {default = "HTTP"}
variable "service_name" { default = "calc" }
variable "service_health_url" { default = "/" }
variable "service_health_status_code" { default = ""}
#variable "alb_sg" {}
variable "service_desired" { default = "1"}
#variable "service_subnet_ids" {}
#variable "service_base_sg" {}
variable "aws_azs" { default = ["eu-west-1a", "eu-west-1b"] }
variable "suffixes_calc"          { default = ["0/28",    "16/28"] }
variable "calc_subnet_base" { default = "10.0.1"}
variable "key_pair" { default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdMZzO5OSo6JVxsa0/apQQ/YvQgnJIFa24m/K55Kv5BbcnwR6ud8R+eFAqXzjh+NfkwlowNzCPLu40r9vebSc1IHR8hQo+5NZUR996hK+GFzYshsC8Q70LL+xj1cnZVKfQ5RiNhCXZtmQfXTXtFEHXAuLcDt5sdZhxwSn/XxXeKswiJ9RqBrSSYj4DZnKKwZ1oQzyhn4HhVLLROUTfIp0eY8LMH32LW+l9Sla1Xi4W2T1p9FJLHb3Ne242mx1s8rgpIALs6ox5qEBR4HSdjzbZNECpgss6s+hhAuKq4OOads5SEZVrcDkVR5BvzOFrf9CluAs3FS7fF0uQxKgSqcTv subeesh@SUBEESH-MAC.local"}
variable "iam_policy_filename" { default = "policy_calc.json"}

#locals { service_count       = "${lookup(var.sizing, "${var.stack_size}_service_count")}"}
