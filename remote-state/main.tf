terraform {
  backend "s3" {
    bucket = "terraform-b73-prafful"
    key = "sample/terraform.tfstate"
    region = "us-east-1"
  }
}

output "demo" {
  value = "Hello All"
}

