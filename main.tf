provider "aws" {
   region     = "ap-south-1"
   access_key = "access-key"
   secret_key = "secret-key"
   #Key should be store in file and give reference
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#provider "aws" {
#  shared_config_files      = "C://Users/shari/.aws/config"
#  shared_credentials_files = "C://Users/shari/.aws/credentials"
#  profile                  = "techlab"
#}

#Local variable configuration
# locals {
#   local_setup = "local_demo"
# }

# #Call local variable
# Name = "${local.local_setup}-vpc"

