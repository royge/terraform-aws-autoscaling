resource "aws_security_group" "public" {
  name        = "${var.namespace}-public"
  description = "Public access"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "http"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal" {
  name        = "${var.namespace}-internal"
  description = "HTTP(s) access within the full internal network"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "http"
    cidr_blocks = "${var.cidr_blocks}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "https"
    cidr_blocks = "${var.cidr_blocks}"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "ssh"
    cidr_blocks = "${var.cidr_blocks}"
  }
}

output "public_sg_id" {
  value = "${aws_security_group.public.id}"
}

output "internal_sg_id" {
  value = "${aws_security_group.internal.id}"
}
