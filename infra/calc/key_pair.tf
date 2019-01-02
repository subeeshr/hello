resource "aws_key_pair" "calc" {
  key_name   = "calc"
  public_key = "${var.key_pair}"
}
