# terraform {
#   # Live modules pin exact Terraform version; generic modules let consumers pin the version.
#   # The latest version of Terragrunt (v0.36.0 and above) recommends Terraform 1.1.4 or above.
#   #required_version = "= 1.1.4"

#   # Live modules pin exact provider version; generic modules let consumers pin the version.
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "= 3.7.0"
#     }
#   }
# }

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "this" {
  ami                     = var.ami
  instance_type           = var.instance_type
}