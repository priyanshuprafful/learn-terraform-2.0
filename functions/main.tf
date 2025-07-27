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

output "aws_topics" {
  value = lookup(lookup(var.classes, "aws", null), "topics" , "topics not found - this is null value" )
}