variable "vpc_cidr" {
  default     = "10.0.0.0/20"
  description = "cidr for VPC"
}
variable "public_subnet" {
  default     = "10.0.0.0/24"
  description = "public_subnet_AZ"
}
variable "private_subnet" {
  default     = "10.0.1.0/24"
  description = "private_subnet_AZ"
}
variable "key" {
  default     = "terraform"
  description = "aws_keypair for authentication"
}
variable "ami" {
  default     = "ami-03cfb5e1fb4fac428"
  description = "amazon_machine_image"
}
variable "type" {
  default     = "t2.micro"
  description = "instance_type"
}

variable "rt" {
  default = "rtb-02d60d69"
  description = "Routetable"
}

variable "vpc_default" {
  default = "172.31.0.0/16"
  description = "cidr"
}


