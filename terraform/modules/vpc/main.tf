resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

}


resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_1_cidr_block
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  availability_zone       = var.availability_zone_1

}


resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_2_cidr_block
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  availability_zone       = var.availability_zone_2

}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_1_cidr_block
  availability_zone = var.availability_zone_1

}


resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_2_cidr_block
  availability_zone = var.availability_zone_2

}


resource "aws_nat_gateway" "ng" {
  subnet_id     = aws_subnet.public_subnet_1.id
  allocation_id = aws_eip.eip.id
}


resource "aws_eip" "eip" {
}


resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.this.id
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.ig.id
  }
}


resource "aws_route_table_association" "public_rta_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "public_rta_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_nat_gateway.ng.id
  }
}


resource "aws_route_table_association" "private_rta_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}


resource "aws_route_table_association" "private_rta_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}