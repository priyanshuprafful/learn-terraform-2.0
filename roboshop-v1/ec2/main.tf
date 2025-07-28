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
resource "aws_instance" "web" {

  ami = data.aws_ami.centos8.id
  instance_type = "t3.small"
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = var.name
  }

}

resource "null_resource" "ansible_tasks" {

  depends_on = [aws_instance.web , aws_route53_record.dns_record]
  provisioner "remote-exec" {

    connection {
      type = "ssh"
      user = "centos"
      password = "DevOps321"
      host = aws_instance.web.public_ip
    }
    inline = [

      "sudo labauto ansible",
      "ansible-pull -i localhost, -U https://github.com/priyanshuprafful/roboshop-ansible-2.0 main.yml -e env=dev -e role_name=${var.name}"

    ]
  }
}

resource "aws_route53_record" "dns_record" {
  zone_id = "Z0465086RMHEURU6S6M8"
  name = "${var.name}-dev"
  type = "A"
  ttl = 30
  records = [aws_instance.web.private_ip]
}

data "aws_ami" "centos8" {

  owners = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
}

resource "aws_security_group" "sg" {
  name = var.name
  description = "Allow TLS inbound traffic"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = var.name
  }
}
variable "name" {}

provider "aws" {
  region = "us-east-1"
}


# output "public_ip" {
#   value = aws_instance.web.public_ip
# }