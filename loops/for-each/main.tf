resource "aws_instance" "roboshop" {

  for_each = var.instances
  ami = data.aws_ami.example.id
  instance_type = "t3.micro"

  tags = {
    Name = each.key["name"] 
  }
}
# Name = "${count.index}" this will give 0 , 1 , 2 as instance name
data "aws_ami" "example" {

  owners = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"

}

variable "instances" {

  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.micro"
    }
    catalogue = {
      name = "catalogue"
      instance_type = "t3.nano"
    }
    cart = {
      name = "cart"
      instance_type = "t3.nano"
    }
  }
}

# for each loop is used for maps
# count is used for list