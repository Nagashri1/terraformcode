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