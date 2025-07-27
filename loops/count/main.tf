terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
resource "aws_instance" "roboshop" {

  count = length(var.instances)
  ami = data.aws_ami.example.id
  instance_type = "t3.micro"

  tags = {
    Name = element(var.instances, count.index)
  }
}
# Name = "${count.index}" this will give 0 , 1 , 2 as instance name
data "aws_ami" "example" {

  owners = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"

}

variable "instances" {
  default = [ "frontend", "catalogue", "cart"]
}