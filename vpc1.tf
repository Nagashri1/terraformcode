resource "aws_vpc" "vpc1" {
    cidr_block = "10.10.0.0/16"
    tags = {
        name = "main"
    }
}

resource "aws_subnet" "sub1" {
    vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.10.0.0/26"

  tags = {
    Name = "Main"
  }
}

resource "aws_route_table" "RT1"{
vpc_id = aws_vpc.vpc1.id
tags = {
  name = "public_rt"
}
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.RT1.id
  subnet_id = aws_subnet.sub1.id
}

resource "aws_route" "route" {
  route_table_id = aws_route_table.RT1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_instance" "server1" {
  ami = "ami-074dc0a6f6c764218"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub1.id
}