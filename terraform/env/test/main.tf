module "networking" {
  source = "../../modules/networking"

  region = "ap-southeast-1"
  name = "test"
  cidr_blocks = [
    # base
    "10.0.0.0/16",
    # primary subnet
    "10.0.1.0/24",
    # secondary subnet
    "10.0.2.0/24"
  ]
}

module "api" {
  source = "../../modules/autoscaling"

  region = "ap-southeast-1"
  name = "test"

  ami_names = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  ami_owners = ["099720109477"] # Canonical

  instance_type = "t2.micro"
  key_name = "terraformtest"
  domain = "terraformtest.io"
  subnets = [
    "${module.networking.primary_subnet_id}",
    "${module.networking.secondary_subnet_id}"
  ]
  security_groups = [
    "${module.networking.internal_sg_id}"
  ]
  public_security_groups = [
    "${module.networking.public_sg_id}"
  ]
}

output "api-dns" {
  value = ["${module.api.default_elb_dns}"]
}
