resource "aws_vpc" "ap_south_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "AP_SOUTH_MUMBAI"
  }
}
resource "aws_subnet" "PublicSubnet" {
  vpc_id     = aws_vpc.ap_south_vpc.id
  cidr_block = var.public_subnet
  tags = {
    Name = "Public_Subnet_ap_south"
  }
  availability_zone = data.aws_availability_zones.available.names[0]
}
resource "aws_subnet" "PrivateSubnet" {
  vpc_id     = aws_vpc.ap_south_vpc.id
  cidr_block = var.private_subnet
  tags = {
    Name = "Private_Subnet_ap_south"
  }
  availability_zone = data.aws_availability_zones.available.names[0]
}
resource "aws_internet_gateway" "ap_south_igw" {
  vpc_id = aws_vpc.ap_south_vpc.id
}
resource "aws_route_table" "public_ap_south_RT" {
  vpc_id = aws_vpc.ap_south_vpc.id
  tags = {
    Name = "Public_RT"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ap_south_igw.id
  }
}
resource "aws_route_table_association" "PublicSubnet" {
  subnet_id      = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.public_ap_south_RT.id
}
resource "aws_route_table" "private_ap_south_RT" {
  vpc_id = aws_vpc.ap_south_vpc.id
  tags = {
    Name = "Private_RT"
  }
}
resource "aws_route_table_association" "PrivateSubnet" {
  subnet_id      = aws_subnet.PrivateSubnet.id
  route_table_id = aws_route_table.private_ap_south_RT.id
}
resource "aws_network_acl" "Public_Nacl" {
  vpc_id     = aws_vpc.ap_south_vpc.id
  subnet_ids = [aws_subnet.PublicSubnet.id]
  egress {
    protocol   = "-1"
    rule_no    = 2
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 1
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "Ap_South_Public"
  }
}
resource "aws_network_acl" "Private_Nacl" {
  vpc_id     = aws_vpc.ap_south_vpc.id
  subnet_ids = [aws_subnet.PrivateSubnet.id]

  egress {
    protocol   = "-1"
    rule_no    = 2
    action     = "allow"
    cidr_block = var.private_subnet
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 1
    action     = "allow"
    cidr_block = var.private_subnet
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "Ap_South_Private"
  }
}

resource "aws_vpc_peering_connection" "Peer_connection" {
  peer_vpc_id   = aws_vpc.ap_south_vpc.id
  vpc_id        = "vpc-94a4befc"
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "default" {
    route_table_id = var.rt
    destination_cidr_block = aws_vpc.ap_south_vpc.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.Peer_connection.id 
}

resource "aws_route" "public_ap_south_RT" {
    route_table_id = aws_route_table.public_ap_south_RT.id
    destination_cidr_block = var.vpc_default
    vpc_peering_connection_id = aws_vpc_peering_connection.Peer_connection.id 
}
