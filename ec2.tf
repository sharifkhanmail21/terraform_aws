################################################################################
# Security Group
################################################################################

#Security Groups Configuration - VPC1
resource "aws_security_group" "vpc1-sec-group-all" {
  name        = "sec-group-all"
  description = "Allow all traffic"
  vpc_id      = "${aws_vpc.vpc1.id}"

  ingress {
    from_port   = 0 # the ICMP type number for 'Echo Reply'
    to_port     = 0 # the ICMP code
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc1 sec group all"
  }
}

#Security Groups Configuration - VPC2
resource "aws_security_group" "vpc2-sec-group-all" {
  name        = "sec-group-all"
  description = "Allow all traffic"
  vpc_id      = "${aws_vpc.vpc2.id}"

  ingress {
    from_port   = 0 # the ICMP type number for 'Echo Reply'
    to_port     = 0 # the ICMP code
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc2 sec group all"
  }
}
################################################################################
# EC2
################################################################################

#To create VPC1 Web1a EC2 instance
resource "aws_instance" "vpc1-web1a-ec2" {
  ami				=	"ami-0f58b397bc5c1f2e8"
  instance_type			=	"t2.micro"
  subnet_id			= aws_subnet.vpc1-websubnet.id
  associate_public_ip_address	= true
  vpc_security_group_ids     = [ "${aws_security_group.vpc1-sec-group-all.id}" ]
  key_name                    = "demo"
  tags = {
    Name = "Web1a"
  }
}

#To create VPC1 Web1b EC2 instance
resource "aws_instance" "vpc1-web1b-ec2" {
  ami				=	"ami-0f58b397bc5c1f2e8"
  instance_type			=	"t2.micro"
  subnet_id			= aws_subnet.vpc1-web2subnet.id
  associate_public_ip_address	= true
  vpc_security_group_ids     = [ "${aws_security_group.vpc1-sec-group-all.id}" ]
  key_name                    = "demo"
  tags = {
    Name = "Web1b"
  }
}


To create VPC1 Public EC2 instance
resource "aws_instance" "vpc1-public-ec2" {
  ami				=	"ami-0f58b397bc5c1f2e8"
  instance_type			=	"t2.micro"
  subnet_id			= aws_subnet.vpc1-websubnet.id
  associate_public_ip_address	= true
  vpc_security_group_ids     = [ "${aws_security_group.vpc1-sec-group-all.id}" ]
  key_name                    = "demo"
#   network_interface {
#     network_interface_id = aws_network_interface.vpc1-pub-demo-eni
#     device_index         = 0
#   }
  tags = {
    Name = "VPC1 Public EC2"
  }
}

#To create VPC1 Private EC2 instance
resource "aws_instance" "vpc1-private-ec2" {
  ami				=	"ami-0f58b397bc5c1f2e8"
  instance_type			=	"t2.micro"
  subnet_id			= aws_subnet.vpc1-appsubnet.id
  count				=	1
  associate_public_ip_address	= false
  vpc_security_group_ids     = [ "${aws_security_group.vpc1-sec-group-all.id}" ]
  key_name                    = "demo"
  tags = {
    Name = "VPC1 Private EC2"
  }
}




#To create VPC2 Public EC2 instance
resource "aws_instance" "vpc2-public-ec2" {
  ami				=	"ami-0f58b397bc5c1f2e8"
  instance_type			=	"t2.micro"
  subnet_id			= aws_subnet.vpc2-websubnet.id
  associate_public_ip_address	= true
  vpc_security_group_ids     = [ "${aws_security_group.vpc2-sec-group-all.id}" ]
  key_name                    = "demo"
  tags = {
    Name = "VPC2 Public EC2"
  }
}

#To create VPC2 Private EC2 instance
resource "aws_instance" "vpc2-private-ec2" {
  ami				=	"ami-0f58b397bc5c1f2e8"
  instance_type			=	"t2.micro"
  subnet_id			= aws_subnet.vpc2-appsubnet.id
  count				=	1
  associate_public_ip_address	= false
  vpc_security_group_ids     = [ "${aws_security_group.vpc2-sec-group-all.id}" ]
  key_name                    = "demo"
  tags = {
    Name = "VPC2 Private EC2"
  }
}





# # #Elastic Network Interface Configuration - VPC1 Public EC2
# # resource "aws_network_interface" "vpc1-pub-demo-eni" {
# #   subnet_id   = aws_subnet.vpc1-websubnet.id
# #   tags = {
# #     Name = "vpc1 Public Demo Network Interface"
# #   }
# # }

# # # #Elastic Network Interface Configuration - VPC1 Private EC2
# # # resource "aws_network_interface" "vpc1-pri-demo-eni" {
# # #   subnet_id   = aws_subnet.vpc1-appsubnet.id
# # #   tags = {
# # #     Name = "vpc1 Private Demo Network Interface"
# # #   }
# # # }

# # #Elastic Network Interface Configuration - VPC2 Public EC2
# # resource "aws_network_interface" "vpc2-pub-demo-eni" {
# #   subnet_id   = aws_subnet.vpc2-websubnet.id
# #   tags = {
# #     Name = "vpc2 Public Demo Network Interface"
# #   }
# # }

# # #Elastic IP Address Allocation - VPC1 Public EC2
# # resource "aws_eip" "pub-eip-ec2" {
# #   instance = aws_instance.vpc1-public-ec2.id
# #   domain   = "vpc"
# # }

# # # #Elastic IP Address Allocation - VPC2 Public EC2
# # # resource "aws_eip" "pri-eip-ec2" {
# # #   instance = aws_instance.vpc2-public-ec2.id
# # #   domain   = "vpc"
# # # }
