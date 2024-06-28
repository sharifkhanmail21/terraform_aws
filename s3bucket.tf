# resource "aws_s3_bucket" "first_bucket" {
#   bucket	= "sreterraform"
#   acl		= "private"
#   tags		= {
#     Name		= "s3.terraform-demo"
#     Environment		= "testing"
#   }
# }

# output "s3ucketOutput" {
#   value = aws_s3_bucket.first_bucket.id
# }