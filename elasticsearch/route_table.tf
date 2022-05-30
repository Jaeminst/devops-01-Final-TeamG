resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.project4_elk.id
    route {
        cidr_block = "0.0.0.0/0"      
        gateway_id = aws_internet_gateway.es-igw.id
    }
  tags = {
    Name = "public_route_table"
  }
}


resource "aws_route_table" "private_route_table-1" {
  vpc_id = aws_vpc.project4_elk.id
  tags = {
    Name = "private_route_table-1"
  }
}


resource "aws_route_table" "private_route_table-2" {
  vpc_id = aws_vpc.project4_elk.id
  tags = {
    Name = "private_route_table-2"
  }
}


resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public_sub_es_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public_sub_es_b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private_sub_es_a.id
  route_table_id = aws_route_table.private_route_table-1.id
}

resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private_sub_es_b.id
  route_table_id = aws_route_table.private_route_table-2.id
}