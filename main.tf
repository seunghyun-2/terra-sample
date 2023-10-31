# main.tf
# AWS Provider Example
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # 5.0 이상
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0" # 5.0 이상
    }
  }
}

# Configure the AWS Provider
provider "aws" {
}

# Create a VPC
module "vpc" {
  source       = "github.com/seunghyun-2/tf-aws_vpc.git"
}

module "subnet" {
  source     = "github.com/seunghyun-2/tf-aws_subnet.git"
}

module "keypair" {
  source   = "github.com/seunghyun-2/tf-aws_keypair.git"
}

# resource "aws_subnet" "terra_private_subnet" {
#   count                   = 2
#   vpc_id                  = aws_vpc.terra_vpc.id
#   cidr_block              = "10.0.${count.index + 2}.0/24"
#   availability_zone       = "${var.aws_region}${count.index % 2 == 0 ? "a" : "b"}"
#   map_public_ip_on_launch = false
#   tags = {
#     "Name"   = "terra_pri_subnet${count.index + 1}"
#     createBy = "terraform"
#   }
# }

# resource "aws_instance" "terra_instance" {
#   for_each          = tomap({ "1" = "${var.aws_region}a", "2" = "${var.aws_region}b" })
#   instance_type     = "t3.micro"
#   availability_zone = each.value
#   ami               = "ami-06018068a18569ff2"
#   subnet_id         = aws_subnet.terra_public_subnet[tonumber(each.key) - 1].id
#   tags = {
#     "Name"   = "terra_instance_${each.value}_${each.key}"
#     createBy = "terraform"
#   }
# }