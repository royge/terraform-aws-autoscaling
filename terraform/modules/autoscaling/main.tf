provider "aws" {
  region = "${var.region}"
  version = "1.8.0"
}

resource "aws_launch_configuration" "apicluster" {
  image_id = "${var.ami}"
  instance_type = "${var.instance_type}"
  security_groups = ["${var.lc_sg_id}"]
  key_name = "${var.key_name}"
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "apigroup" {
  launch_configuration = "${aws_launch_configuration.apicluster.name}"
  vpc_zone_identifier = "${var.subnets_id}"
  min_size = "${var.min_autoscaling_size}"
  max_size = "${var.max_autoscaling_size}"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances",
  ]
  metrics_granularity = "1Minute"
  load_balancers = ["${aws_elb.apielb.id}"]
  health_check_type = "ELB"

  tag {
    key = "Name"
    value = "API server autoscaling group"
    propagate_at_launch = true
  }
}
