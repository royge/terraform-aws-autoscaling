# AWS Region
variable "region" {}

variable "min" {
  default = 1
}

variable "max" {
  default = 2
}

variable "cap" {
  default = 1
}

variable "security_groups" {
  type = "list"
}

variable "instance_type" {}
variable "key_name" {}

variable "name" {}

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

variable "ami_names" {
  type = "list"
}

variable "ami_owners" {
  type = "list"
}

variable "domain" {}
variable "public_security_groups" {
  type = "list"
}
variable "subnets" {
  type = "list"
}
variable "health_check_target" {
  default = "HTTPS:443/"
}
