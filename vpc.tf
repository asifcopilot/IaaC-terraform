## Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name    = "Devops-tf"
    Project = "terraform"
  }
}

resource "aws_subnet" "pubsub1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pubsub1
  map_public_ip_on_launch = true
  availability_zone       = var.az1

  tags = {
    Name = "pubsub1"
  }
}

resource "aws_subnet" "pubsub2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pubsub2
  map_public_ip_on_launch = true
  availability_zone       = var.az2

  tags = {
    Name = "pubsub2"
  }
}

resource "aws_subnet" "pubsub3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pubsub3
  map_public_ip_on_launch = true
  availability_zone       = var.az3

  tags = {
    Name = "pubsub3"
  }
}

resource "aws_subnet" "privsub1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.privsub1

  tags = {
    Name = "pubsub1"
  }
}

resource "aws_subnet" "privsub2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.privsub2

  tags = {
    Name = "pubsub2"
  }
}

resource "aws_subnet" "privsub3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.privsub3

  tags = {
    Name = "pubsub3"
  }
}

resource "aws_internet_gateway" "devops-tf-ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name    = "Devops-tf-IG"
    project = "terraform"
  }
}

# resource "aws_internet_gateway_attachment" "ig-attached" {
#     vpc_id = aws_vpc.vpc.id
#     internet_gateway_id = aws_internet_gateway.devops-tf-ig.id

# }

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops-tf-ig.id
  }
  tags = {
    Name    = "pub-rt"
    project = "terraform"
  }
}

resource "aws_route_table_association" "rt-pub1" {
  route_table_id = aws_route_table.pub-rt.id
  subnet_id      = aws_subnet.pubsub1.id
}

resource "aws_route_table_association" "rt-pub2" {
  route_table_id = aws_route_table.pub-rt.id
  subnet_id      = aws_subnet.pubsub2.id
}

resource "aws_route_table_association" "rt-pub3" {
  route_table_id = aws_route_table.pub-rt.id
  subnet_id      = aws_subnet.pubsub3.id
}