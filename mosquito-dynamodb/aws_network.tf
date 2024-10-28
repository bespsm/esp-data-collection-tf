# aws_network.tf

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.tag
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = var.tag
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = var.tag
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet
  map_public_ip_on_launch = true
  depends_on              = [aws_internet_gateway.this]
  tags = {
    Name = "${var.tag}-public"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
