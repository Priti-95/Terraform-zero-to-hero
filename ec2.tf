# Region

provider "aws" {

  region = "ap-south-1"
}

# Key value pair

resource "aws_key_pair" "my_key_pair" {

  key_name   = "terra-automate-key-pair"
  public_key = file("/home/ubuntu/.ssh/id_ed25519.pub")
}

# Default VPC

resource "aws_default_vpc" "default" {
}

# Security group

resource "aws_security_group" "my_security_group" {

  name        = "terra-security-group"
  vpc_id      = aws_default_vpc.default.id # interpolation
  description = "this is Inbound and Outbound rules for your instance security group"
}

# Inbound and Outbound port rules

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# EC2 Instance

resource "aws_instance" "my_instance" {

  count = 3
  tags = {
    Name = "terra-automate-server"
  }
  ami                    = "ami-05d2d839d4f73aafb" # AMI id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.my_key_pair.key_name         # key pair
  vpc_security_group_ids = [aws_security_group.my_security_group.id] # VPC and Security group

  # EBS (Root storage)

  root_block_device {

    volume_size = 8
    volume_type = "gp3"
  }

}
