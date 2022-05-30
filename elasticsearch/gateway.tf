resource "aws_internet_gateway" "es-igw" {
    vpc_id = aws_vpc.project4_elk.id
    tags = {
        Name = "es-igw"
    }
}


resource "aws_eip" "es-eip"{
    vpc = true
    lifecycle {
    create_before_destroy = true
  }
}


resource "aws_nat_gateway" "es-nat-gateway" {
  allocation_id = aws_eip.es-eip.id
  subnet_id     = aws_subnet.public_sub_es_a.id

  tags = {
    Name = "es-nat-gateway"
  }

  depends_on = [aws_internet_gateway.es-igw]
} 