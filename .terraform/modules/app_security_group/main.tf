provider "aws" {
  region = var.aws_region
}
 
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
 
  tags = {
    Name = "${var.prefix}-vpc"
  }
}
 
resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
 
  tags = {
    Name = "${var.prefix}-subnet"
  }
}
 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
 
  tags = {
    Name = "${var.prefix}-igw"
  }
}
 
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
 
  tags = {
    Name = "${var.prefix}-route-table"
  }
}
 
resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}
 
# Security Group Modules
module "bastion_security_group" {
  source         = "./path/to/your/security_group_module"
  security_groups = var.bastion_security_groups
  vpc_id         = aws_vpc.vpc.id
}
 
module "web_security_group" {
  source         = "./path/to/your/security_group_module"
  security_groups = var.web_security_groups
  vpc_id         = aws_vpc.vpc.id
}
 
module "web_security_group1" {
  source         = "./path/to/your/security_group_module"
  security_groups = var.web_security_groups1
  vpc_id         = aws_vpc.vpc.id
}
 
module "app_security_group" {
  source         = "./path/to/your/security_group_module"
  security_groups = var.app_security_groups
  vpc_id         = aws_vpc.vpc.id
}
 
module "app_security_group1" {
  source         = "./path/to/your/security_group_module"
  security_groups = var.app_security_groups1
  vpc_id         = aws_vpc.vpc.id
}
 
module "db_security_group" {
  source         = "./path/to/your/security_group_module"
  security_groups = var.db_security_groups
  vpc_id         = aws_vpc.vpc.id
}
 