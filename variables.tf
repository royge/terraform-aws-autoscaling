# AWS Region
variable "region" {
  description = "AWS region"
}

variable "min" {
  default = 1
  description = "Minimum number of EC2 instances"
}

variable "max" {
  default = 2
  description = "Maximum number of EC2 instances"
}

variable "cap" {
  default = 1
  description = "Desired number of EC2 instances."
}

variable "security_groups" {
  type = "list"
  description = "List of security group IDs"
}

variable "instance_type" {
  description = "EC2 instance type to be used"
}
variable "key_name" {
  description = "Keypair name"
}

variable "name" {
  description = "Namespace"
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
  description = "Autoscaling metrics"
}

variable "ami_names" {
  type = "list"
  description = "AMI names filter"
}

variable "ami_owners" {
  type = "list"
  description = "AMI owner"
}

variable "domain" {
  description = "Domain name"
}
variable "public_security_groups" {
  type = "list"
  description = "Publicly accessible security group IDs"
}
variable "subnets" {
  type = "list"
  description = "List of subnet IDs"
}
variable "health_check_target" {
  default = "HTTPS:443/"
  description = "ELB health check URL"
}
