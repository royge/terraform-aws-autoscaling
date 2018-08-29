provider "aws" {
  region = "${var.region}"
  version = "1.33.0"
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_blocks[0]}"

  tags {
    Name = "${var.namespace} - main"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.namespace} - main"
  }
}

resource "aws_subnet" "primary" {
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block = "${var.cidr_blocks[1]}"

  tags {
    Name = "Primary"
  }
}

resource "aws_subnet" "secondary" {
  vpc_id = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block = "${var.cidr_blocks[2]}"

  tags {
    Name = "Secondary"
  }
}

variable "region" {}

variable "namespace" {}

variable "cidr_blocks" {
  type = "list"
  description = "List of CIDR blocks. The first will be the base CIDR of the VPC"
}

output "primary_subnet_id" {
  value = "${aws_subnet.primary.id}"
}

output "secondary_subnet_id" {
  value = "${aws_subnet.secondary.id}"
}
