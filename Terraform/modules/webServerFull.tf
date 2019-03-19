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

module "infrastructure" {
  source = "../ComputeR"
}

module "networking" {
  source = "../NetworkingR"
}