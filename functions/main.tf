variable "class" {
  default = "DevOps"
}

output "class" {
  value = upper(var.class)
}

variable "classes" {
  default = {
    devops = {
      name = "DevOps"
      topics = ["jenkins", "docker"]
    }
    aws = {
      name = "aws"
    }
  }
}

output "devops_topics" {
  value = var.classes["devops"]["topics"]
}
#
output "aws_topics" {
  value = lookup(lookup(var.classes, "aws", null), "topics" , "topics not found - this is null value" )
}

# output "aws_topics" {
#   value = lookup(lookup(var.classes, "aws", null), "topics" , null ) == null ? "No aws training topics added" : lookup(lookup(var.classes, "aws", null), "topics" , "topics not found - this is null value" )
# }
#


variable "fruits" {
  default = ["apple", "pineapple", "orange"]
}

output "fruit_4" {
  value = element(var.fruits, 4)
}

variable "a" {
  default = 100
}

output "a" {
  value = var.a > 100 ? "Surplus Quantity" : "Less Quantity"
}

# element is to pickup value from list
# lookup is to pickup value from the map