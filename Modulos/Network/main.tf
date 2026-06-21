resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Chewbacca-VPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Chewbacca-IGW"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Chewbacca-PubSub-${count.index + 1}"
  }
}

resource "aws_subnet" "app" {
  count = length(var.app_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = var.app_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "Chewbacca-AppSub-${count.index + 1}"
  }
}

resource "aws_subnet" "db" {
  count = length(var.db_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = var.db_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "Chewbacca-DBsSub-${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "Chewbacca-PubRT"
  }
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  count = length(var.public_subnets)
  domain = "vpc"
  depends_on = [
    aws_internet_gateway.main
  ]
  tags = {
    Name = "Chewbacca-EIP-${count.index}"
  }
}

resource "aws_nat_gateway" "nat" {
  count = length(var.public_subnets)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id = aws_subnet.public[count.index].id
  depends_on = [
    aws_internet_gateway.main
  ]
  tags = {
    Name = "Chewbacca-NAT-${count.index}"
  }
}

resource "aws_route_table" "private_app_0" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[0].id
  }
  tags = {
    Name = "Chewbacca-App-0"
  }
}

resource "aws_route_table" "private_app_1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[1].id
  }
  tags = {
    Name = "Chewbacca-App-1"
  }
}

resource "aws_route_table_association" "app_0" {
  subnet_id = aws_subnet.app[0].id
  route_table_id = aws_route_table.private_app_0.id
}

resource "aws_route_table_association" "app_1" {
  subnet_id = aws_subnet.app[1].id
  route_table_id = aws_route_table.private_app_1.id
}