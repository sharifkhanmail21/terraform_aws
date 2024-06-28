Variable "aws-region" {
  description = "Configure AWS Region"
  type = string
  default = "ap-sourth-a"
}

Variable "user-name" {
  description = "IAM User"
  type = list(string)
  default = ["demo1","demo2","demo3"]
}
