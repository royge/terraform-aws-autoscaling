output "default_elb_dns" {
  value = "${aws_elb.default.dns_name}"
}
