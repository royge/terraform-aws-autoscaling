provider "aws" {
  region = "${var.region}"
  version = "1.33.0"
}

data "aws_ami" "default" {
  most_recent = true

  filter = {
    name = "name"
    values = "${var.ami_names}"
  }

  owners = "${var.ami_owners}"
}

variable "ami_names" {
  type = "list"
}

variable "ami_owners" {
  type = "list"
}

resource "aws_launch_configuration" "cluster" {
  name = "${var.namespace}-config"
  image_id = "${data.aws_ami.default.image_id}"
  instance_type = "${var.instance_type}"
  security_groups = ["${var.security_groups}"]
  key_name = "${var.key_name}"
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "default" {
  name = "${var.namespace}-group"
  launch_configuration = "${aws_launch_configuration.cluster.name}"
  vpc_zone_identifier = ["${var.subnets}"]
  min_size = "${var.min}"
  max_size = "${var.max}"
  enabled_metrics = "${var.metrics}"
  metrics_granularity = "1Minute"
  load_balancers = ["${aws_elb.default.id}"]
  health_check_type = "ELB"

  tag {
    key = "Name"
    value = "${var.name}"
    propagate_at_launch = true
  }
}

# AWS Region
variable "region" {}

variable min {
  default = 1
}

variable max {
  default = 2
}

variable "security_groups" {
  type = "list"
}

variable "instance_type" {}
variable "key_name" {}

variable "namespace" {}
variable "name" {
  default="API sever"
}

variable "metrics" {
  type = "list"
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances",
  ]
}
