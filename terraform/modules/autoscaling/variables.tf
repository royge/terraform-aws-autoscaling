# AWS Region
variable "region" {}

# EC2 AMI
variable "ami" {}

variable min_autoscaling_size {
  default = 1
}

variable max_autoscaling_size {
  default = 2
}

# SSL Certificate
variable "ssl_certificate" {}

# EC2 instance type. Ex. t2.micro
variable "instance_type" {}

# SSH key name
variable "key_name" {}

# VPC ID
variable "vpc_id" {}

# ELB security group ID
variable "elb_sg_id" {}

# Launch configuration security group ID
variable "lc_sg_id" {}

# Subnets ID
variable "subnets_id" {
  type="list"
}

# S3 bucket name for logs
variable "logs_s3_bucket" {}

# virtualenv directory path
variable "venv_dir" {}

# Application directory path
variable "app_dir" {}
