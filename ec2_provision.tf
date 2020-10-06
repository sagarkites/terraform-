resource "aws_security_group" "ap_south_sg" {
  name        = "ap_south_sg"
  description = "port22_open_sg"
  vpc_id      = aws_vpc.ap_south_vpc.id
  ingress {
    description = "Security Group"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ap_south_sg"
  }
}
resource "aws_instance" "ec2_test" {
    ami = var.ami
    subnet_id = aws_subnet.PublicSubnet.id
    instance_type = var.type
    security_groups = [ aws_security_group.ap_south_sg.id ]
    key_name = var.key
    associate_public_ip_address = true
    tags = {
    Name = "Devlopment_PHP"
   } 
}
