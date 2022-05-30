resource "aws_subnet" "public_sub_es_a" {
  vpc_id     = aws_vpc.project4_elk.id
  cidr_block = "172.18.0.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "public_sub_es_a"
  }
}

resource "aws_subnet" "public_sub_es_b" {
  vpc_id     = aws_vpc.project4_elk.id
  cidr_block = "172.18.1.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "public_sub_es_b"
  }
}

resource "aws_subnet" "private_sub_es_a" {
  vpc_id     = aws_vpc.project4_elk.id
  cidr_block = "172.18.3.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "private_sub_es_a"
  }
}

resource "aws_subnet" "private_sub_es_b" {
  vpc_id     = aws_vpc.project4_elk.id
  cidr_block = "172.18.4.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "private_sub_es_b"
  }
}