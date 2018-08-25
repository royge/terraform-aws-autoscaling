module "networking" {
  source = "../../modules/networking"

  region = "ap-southeast-1"
  namespace = "test"
  cidr_blocks = [
    # base CIDR block
    "10.0.0.0/16"
  ]
}

module "api" {
  source = "../../modules/autoscaling"

  region = "ap-southeast-1"
  namespace = "test"

  ami_names = [""]
  ami_owners = [""]

  instance_type = "t2.micro"
  key_name = "test"
  domain = "tf.example.com"
  vpc_zone_id = "${module.networking.primary_subnet_id}"
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
