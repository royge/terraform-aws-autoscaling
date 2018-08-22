terraform {
    backend "s3" {
    bucket = "terraform-state"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
}

module "api" {
  source = "../../modules/autoscaling"

  region = "ap-southeast-1"
  ami = "ami-ec589898"
  min_autoscaling_size = 1
  instance_type = "t2.micro"
  key_name = "test"
  logs_s3_bucket = "mybucket"
  vpc_id = "vpc-90451x53"
  subnets_id = ["subnet-002bed49", "subnet-77fe2d10"]
  elb_sg_id = "sg-5aa6233c"
  lc_sg_id = "sg-22a12444"
  ssl_certificate = "arn:aws:acm:ap-southeast-1:994359151799:certificate/dafef8b2-10da-4cc7-923a-b0a36eeaee67"
}

output "api" {
  value = ["${module.api.api_elb_dns}"]
}
