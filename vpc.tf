
#VPC1 Configuration
resource "aws_vpc" "vpc1" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "VPC1"
  }
}

#Subnet Configuration - Transit
resource "aws_subnet" "vpc1-Trasitsubnet" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.1.100.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "VPC1 Transit Subnet"
  }
}

#Subnet Configuration - Web1a
resource "aws_subnet" "vpc1-websubnet" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "VPC1 Web1a Subnet"
  }
}

#Subnet Configuration - Web1b
resource "aws_subnet" "vpc1-web2subnet" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "VPC1 Web1b Subnet"
  }
}

# #Subnet Configuration - App
# resource "aws_subnet" "vpc1-appsubnet" {
#   vpc_id     = aws_vpc.vpc1.id
#   cidr_block = "10.1.2.0/24"
#   availability_zone = "ap-south-1b"
#   map_public_ip_on_launch = false
#   tags = {
#     Name = "VPC1 App Subnet"
#   }
# }

#Route Table Configuration - VPC1 Public Subnet
resource "aws_route_table" "vpc1-pub-rt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  # route {
  #   cidr_block = "10.2.0.0/16"
  #   transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  # }
  tags = {
    Name = "VPC1 Pub RT"
  }
}

# #Route Table Configuration - VPC1 Private Subnet
# resource "aws_route_table" "vpc1-pri-rt" {
#   vpc_id = aws_vpc.vpc1.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.natgw.id
#   }
#   route {
#     cidr_block = "10.2.0.0/16"
#     transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#   }
#   tags = {
#     Name = "VPC1 Pri RT"
#   }
# }

#Subnet Association to Route Table (Transit)
resource "aws_route_table_association" "vpc1-transit-subnet-Association" {
  subnet_id      = aws_subnet.vpc1-Trasitsubnet.id
  route_table_id = aws_route_table.vpc1-pub-rt.id
}

#Subnet Association to Route Table (Public)
resource "aws_route_table_association" "vpc1-web-subnet-Association" {
  subnet_id      = aws_subnet.vpc1-websubnet.id
  route_table_id = aws_route_table.vpc1-pub-rt.id
}

#Subnet Association to Route Table (Public)
resource "aws_route_table_association" "vpc1-web2-subnet-Association" {
  subnet_id      = aws_subnet.vpc1-web2subnet.id
  route_table_id = aws_route_table.vpc1-pub-rt.id
}

# #Subnet Association to Route Table (Private)
# resource "aws_route_table_association" "vpc1-app-subnet-Association" {
#   subnet_id      = aws_subnet.vpc1-appsubnet.id
#   route_table_id = aws_route_table.vpc1-pri-rt.id
# }

#Internet Gateway Configuration
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "IGW"
  }
}


# #Elastic IP Address Allocation for NAT GW
# resource "aws_eip" "nat_eip" {
#   domain   = "vpc"
# }

# #NAT Gateway Configuration
# resource "aws_nat_gateway" "natgw" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.vpc1-websubnet.id
#   connectivity_type = "public"
#   tags = {
#     Name = "NAT GW"
#   }
#   depends_on = [aws_internet_gateway.igw]
# }




# #VPC2 Configuration
# resource "aws_vpc" "vpc2" {
#   cidr_block       = "10.2.0.0/16"
#   instance_tenancy = "default"
#   tags = {
#     Name = "VPC2"
#   }
# }

# #Subnet Configuration - Transit
# resource "aws_subnet" "vpc2-Trasitsubnet" {
#   vpc_id     = aws_vpc.vpc2.id
#   cidr_block = "10.2.100.0/24"
#   availability_zone = "ap-south-1a"
#   tags = {
#     Name = "VPC2 Transit Subnet"
#   }
# }

# #Subnet Configuration - Web
# resource "aws_subnet" "vpc2-websubnet" {
#   vpc_id     = aws_vpc.vpc2.id
#   cidr_block = "10.2.1.0/24"
#   availability_zone = "ap-south-1a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "VPC2 Web Subnet"
#   }
# }

# #Subnet Configuration - App
# resource "aws_subnet" "vpc2-appsubnet" {
#   vpc_id     = aws_vpc.vpc2.id
#   cidr_block = "10.2.2.0/24"
#   availability_zone = "ap-south-1b"
#   map_public_ip_on_launch = false
#   tags = {
#     Name = "VPC2 App Subnet"
#   }
# }

# #Route Table Configuration - VPC2 Public Subnet
# resource "aws_route_table" "vpc2-pub-rt" {
#   vpc_id = aws_vpc.vpc2.id

#   # route {
#   #   cidr_block = "0.0.0.0/0"
#   #   gateway_id = aws_internet_gateway.igw.id
#   # }
#   route {
#     cidr_block = "10.1.0.0/16"
#     transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#   }
#   tags = {
#     Name = "VPC2 Pub RT"
#   }
# }

# #Route Table Configuration - VPC2 Private Subnet
# resource "aws_route_table" "vpc2-pri-rt" {
#   vpc_id = aws_vpc.vpc2.id

#   # route {
#   #   cidr_block = "0.0.0.0/0"
#   #   gateway_id = aws_nat_gateway.natgw.id
#   # }
#   route {
#     cidr_block = "10.1.0.0/16"
#     transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#   }
#   tags = {
#     Name = "VPC2 Pri RT"
#   }
# }

# #Subnet Association to Route Table (Transit)
# resource "aws_route_table_association" "vpc2-transit-subnet-Association" {
#   subnet_id      = aws_subnet.vpc2-Trasitsubnet.id
#   route_table_id = aws_route_table.vpc2-pub-rt.id
# }

# #Subnet Association to Route Table (Public)
# resource "aws_route_table_association" "vpc2-web-subnet-Association" {
#   subnet_id      = aws_subnet.vpc2-websubnet.id
#   route_table_id = aws_route_table.vpc2-pub-rt.id
# }

# #Subnet Association to Route Table (Private)
# resource "aws_route_table_association" "vpc2-app-subnet-Association" {
#   subnet_id      = aws_subnet.vpc2-appsubnet.id
#   route_table_id = aws_route_table.vpc2-pri-rt.id
# }







# #Transit Gateway Configuration
# resource "aws_ec2_transit_gateway" "tgw" {
#   description                     = "Transit Gateway"
#   default_route_table_association = "disable"
#   default_route_table_propagation = "disable"
#   tags                            = {
#     Name                          = "Transit GW"
#   }
# }

# #Transit Gateway - VPC1 Attachment
# resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc1" {
#   transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#   vpc_id             = aws_vpc.vpc1.id
#   subnet_ids         = [ "${aws_subnet.vpc1-Trasitsubnet.id}" ]
#   transit_gateway_default_route_table_association = false
#   transit_gateway_default_route_table_propagation = false
#   tags               = {
#     Name             = "TGW VPC1 Attachment"
#   }
# }

# #Transit Gateway - VPC2 Attachment
# resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc2" {
#   transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#   vpc_id             = aws_vpc.vpc2.id
#   subnet_ids         = [ "${aws_subnet.vpc2-Trasitsubnet.id}" ]
#   transit_gateway_default_route_table_association = false
#   transit_gateway_default_route_table_propagation = false
#   tags               = {
#     Name             = "TGW VPC2 Attachment"
#   }
# }

# resource "aws_ec2_transit_gateway_route" "tgw-route-vpc1" {
#   destination_cidr_block         = "10.2.0.0/16"
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc1.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-rt.id
# }

# resource "aws_ec2_transit_gateway_route" "tgw-route-vpc2" {
#   destination_cidr_block         = "10.1.0.0/16"
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc2.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-rt.id
# }

# #Tramsit Gateway - Route Table
# resource "aws_ec2_transit_gateway_route_table" "tgw-rt" {
#   transit_gateway_id = aws_ec2_transit_gateway.tgw.id
#   tags               = {
#     Name             = "TGW-RT"
#   }
# }

# #Transit Gateway - VPC1 Route Table Association
# resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-1-assoc" {
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc1.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-rt.id
# }

# #Transit Gateway - VPC2 Route Table Association
# resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-2-assoc" {
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc2.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw-rt.id
# }




