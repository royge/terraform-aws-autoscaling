data "aws_acm_certificate" "default" {
  domain   = "${var.domain}"
  most_recent = true
}

data "aws_ami" "default" {
  most_recent = true

  filter {
    name = "name"
    values = "${var.ami_names}"
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = "${var.ami_owners}"
}
