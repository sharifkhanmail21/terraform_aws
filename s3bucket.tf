#S3 Bucket Configuration
resource "aws_s3_bucket" "techt-lb-logs" {
  bucket	= "techt-lb-logs"
  tags		= {
    Name		= "LB Log"
    Environment		= "Lab"
  }
}

output "s3ucketOutput" {
  value = aws_s3_bucket.techt-lb-logs.id
}
