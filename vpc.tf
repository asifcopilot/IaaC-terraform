variable "region" {}
variable "vpc-cidr" {}
variable "env" {}
variable "az" {
  type = list(any)
}

variable "public-sub" {
  type = list(any)
}


resource "aws_vpc" "devops-vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = "true"
  tags = {
    Name    = "${var.env}-devops-vpc"
    project = "Devops"
  }
}

resource "aws_subnet" "public-sub-1" {
  vpc_id                  = aws_vpc.devops-vpc.id
  availability_zone       = var.az[0]
  cidr_block              = var.public-sub[0]
  map_public_ip_on_launch = true
  tags = {
    Name    = "${var.env}-public-sub-1"
    project = "devops"
  }
}

resource "aws_subnet" "public-sub-2" {
  vpc_id                  = aws_vpc.devops-vpc.id
  availability_zone       = var.az[1]
  cidr_block              = var.public-sub[1]
  map_public_ip_on_launch = true
  tags = {
    Name    = "${var.env}public-sub-2"
    project = "devops"
  }
}


resource "aws_subnet" "public-sub-3" {
  vpc_id                  = aws_vpc.devops-vpc.id
  availability_zone       = var.az[2]
  cidr_block              = var.public-sub[2]
  map_public_ip_on_launch = true
  tags = {
    Name    = "${var.env}public-sub-3"
    project = "devops"
  }
}

resource "aws_internet_gateway" "IW" {
  vpc_id = aws_vpc.devops-vpc.id
  tags = {
    Name    = "${var.env}devops-IG"
    project = "devops"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.devops-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IW.id
  }
  tags = {
    Name    = "${var.env}public-RT"
    project = "devops"
  }
}

resource "aws_route_table_association" "public-sub-1" {
  subnet_id      = aws_subnet.public-sub-1.id
  route_table_id = aws_route_table.public-RT.id
}

resource "aws_route_table_association" "public-sub-2" {
  subnet_id      = aws_subnet.public-sub-2.id
  route_table_id = aws_route_table.public-RT.id
}

resource "aws_route_table_association" "public-sub-3" {
  subnet_id      = aws_subnet.public-sub-3.id
  route_table_id = aws_route_table.public-RT.id
}