################################################################################
# Application Load Balancer
################################################################################

// Target Group
resource "aws_lb_target_group" "web-tg" {
 name     = "web-tg"
 port     = 80
 protocol = "HTTP"
 vpc_id   = aws_vpc.vpc1.id
}

// Target group Attachment
resource "aws_lb_target_group_attachment" "web-tg_attachment" {
 target_group_arn = aws_lb_target_group.web-tg.arn
 target_id        = aws_instance.vpc1-web1a-ec2.id
 port             = 80
}

// Target group Attachment
resource "aws_lb_target_group_attachment" "web1b-tg_attachment" {
 target_group_arn = aws_lb_target_group.web-tg.arn
 target_id        = aws_instance.vpc1-web1b-ec2.id
 port             = 80
}

#Application Load Balancer
resource "aws_lb" "web-alb" {
  name               = "Web-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vpc1-sec-group-all.id]

  subnet_mapping {
    subnet_id            = aws_subnet.vpc1-websubnet.id
#    private_ipv4_address = "10.1.1.15"
  }
  subnet_mapping {
    subnet_id            = aws_subnet.vpc1-web2subnet.id
#    private_ipv4_address = "10.1.2.15"
  }

 enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.techt-lb-logs.id
  #   prefix  = "web-alb"
  #   enabled = true
  # }

  tags = {
    Environment = "Lab"
  }
}

// Listener
resource "aws_lb_listener" "my_alb_listener" {
 load_balancer_arn = aws_lb.web-alb.arn
 port              = "80"
 protocol          = "HTTP"

 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.web-tg.arn
 }
}

################################################################################
# Network Load Balancer
################################################################################



