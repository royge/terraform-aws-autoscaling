provider "aws" {
  region = "${var.region}"
  version = "1.33.0"
}

resource "aws_launch_configuration" "cluster" {
  image_id = "${data.aws_ami.default.image_id}"
  instance_type = "${var.instance_type}"
  security_groups = ["${var.security_groups}"]
  key_name = "${var.key_name}"
  associate_public_ip_address = true
  user_data = "${file("userdata.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "default" {
  name = "${var.name}-group"
  launch_configuration = "${aws_launch_configuration.cluster.name}"
  vpc_zone_identifier = ["${var.subnets}"]
  min_size = "${var.min}"
  max_size = "${var.max}"
  desired_capacity = "${var.cap}"
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
