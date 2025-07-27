terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
resource "aws_instance" "roboshop" {

  count = 3
  ami = data.aws_ami.example.id
  instance_type = "t3.micro"

  tags = {
    Name = "Simple Instance"
  }
}

data "aws_ami" "example" {

  owners = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"

}