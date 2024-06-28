# provider "aws" {
#   region     = "ap-south-1"
#   access_key = "AKIATCKARAQL2QDQBTJ4"
#   secret_key = "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"
#   #Key should be store in file and give reference
# }

provider "aws" {
  shared_config_files      = "C://Users/shari/.aws/conf"
  shared_credentials_files = "C://Users/shari/.aws/credentials"
  profile                  = "techlab"
}

#Local variable configuration
# locals {
#   local_setup = "local_demo"
# }

# #Call local variable
# Name = "${local.local_setup}-vpc"

