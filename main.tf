terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("/home/ubuntu/.ssh/mykey.pub")
}

resource "aws_default_vpc" "vpc" {}

resource "aws_security_group" "allow_traffic" {
  name        = "allow_traffic"
  description = "allow ssh inbound traffic - ingress rules"
  vpc_id      = aws_default_vpc.vpc.id

  ingress {
    description = "SSH ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_traffic"
  }
}

resource "aws_instance" "my_ec2" {
  count         = 2
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"

  key_name         = aws_key_pair.mykey.key_name
  security_groups  = [aws_security_group.allow_traffic.name]

  tags = {
    Name = "SecuredInstance-${count.index + 1}"
  }
}

output "instance_public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = aws_instance.my_ec2[*].public_ip
}
