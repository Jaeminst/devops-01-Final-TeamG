resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.project4_team.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route_table_public"
  }
}

resource "aws_route_table" "route_table_private" {
    vpc_id = aws_vpc.project4_team.id
    tags = {
        Name = "private route table"
    }
}