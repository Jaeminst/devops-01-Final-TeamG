resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.project4_team.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.project4_team.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "public2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.project4_team.id
  cidr_block = "10.10.10.0/24"

  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.project4_team.id
  cidr_block = "10.10.11.0/24"

  tags = {
    Name = "private2"
  }
}