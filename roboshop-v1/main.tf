terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"

    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}



module "instances" {

  for_each = var.instances
  source = "./ec2"
  name = each.key
}


variable "instances" {

  default = {

    frontend = {}
    mongodb = {}
    catalogue = {}
    redis = {}
    user = {}
    cart = {}
    mysql = {}
    shipping = {}
    rabbitmq = {}
    payment = {}
  }
}
