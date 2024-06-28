# #To create EC2 instance
# resource "aws_instance" "Demo" {
#   ami				=	"get ami from console"
#   instance_type			=	"t2.micro - get from console"
#   vpc_security_group_ids	=	[ "${aws_security_group.security_group.id}" ]
#   subnet_id			= "${aws_subnet.public_subnet.id}"
#   count				=	1
#   associate_public_ip_address	= true
#   key_name			=	"Get from console"
#   tags		= {
# 	name	= "Instance_Name"
#   }
# }