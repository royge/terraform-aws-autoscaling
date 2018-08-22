resource "aws_elb" "apielb" {
  name = "api-elb"
  security_groups = ["${var.elb_sg_id}"]
  subnets = "${var.subnets_id}"

  listener {
    instance_port = 443
    instance_protocol = "https"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port      = 443
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${var.ssl_certificate}"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTPS:443/"
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

resource "aws_lb_cookie_stickiness_policy" "api_cookie_stickness" {
  name = "apicookiestickness"
  load_balancer = "${aws_elb.apielb.id}"
  lb_port = 80
  cookie_expiration_period = 600
}
