provider "aws" {
    region     = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "2018-19tfstatesproject"
    key    = "terraform.state"
    region = "eu-west-1"
  }
}
data "terraform_remote_state" "wsm" {
  backend = "s3"
  config {
    bucket = "2018-19tfstatesproject"
    key    = "terraform.state"
    region = "eu-west-1"
  }
}

module "infrastructure" {
  source                   = "../modules/ComputeR"
  vpc_subs                 = "${module.networking.subnet_ids}"
  vpc_id                   = "${module.networking.vpc_id}"
  webMainSec_id            = "${module.security.webMainSec_id}"
  server_max_count         = "${var.server_max_count}"
  server_min_count         = "${var.server_min_count}"
  custom_AMI               = "${var.custom_AMI}"
  web_server_instance_type = "${var.web_server_instance_type}" 
  environment              = "${var.environment}"
}

module "networking" {
  source = "../modules/NetworkingR"
}

module "security" {
  source      = "../modules/SecurityR"
  vpc_id      = "${module.networking.vpc_id}"
  environment = "${var.environment}"
}
