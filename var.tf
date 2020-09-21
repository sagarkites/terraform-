variable "vpc_cidr" {
    default = "10.0.0.0/16"
  description = "cidr for VPC"
}
variable "public_subnet" {
  default = "10.0.0.0/24"
  description = "public_subnet_AZ"
}
variable "private_subnet" {
  default = "10.0.1.0/24"
  description = "private_subnet_AZ"
}
variable "key"{
    default = "trouble"
    description = "aws_keypair for authentication" 
}
variable "ami" {
    default = "ami-09a7bbd08886aafdf"
    description = "amazon_machine_image"
}
variable "type" {
    default = "t2.micro"
    description = "instance_type"
}
