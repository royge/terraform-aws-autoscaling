resource "aws_elb" "default" {
  name = "${var.name}-default-elb"
  security_groups = ["${var.public_security_groups}"]
  subnets = ["${var.subnets}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port      = 443
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${data.aws_acm_certificate.default.arn}"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "${var.health_check_target}"
    interval = 30
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "api-elb"
  }
}

resource "aws_lb_cookie_stickiness_policy" "default" {
  name = "${var.name}defaultcookiestickness"
  load_balancer = "${aws_elb.default.id}"
  lb_port = 80
  cookie_expiration_period = 600
}
