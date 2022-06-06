resource "aws_route_table_association" "route_table_public_a" {
    subnet_id      = aws_subnet.public1.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "route_table_public_b" {
    subnet_id      = aws_subnet.public2.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "route_table_private_a" {
    subnet_id      = aws_subnet.private1.id
    route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "route_table_private_b" {
    subnet_id      = aws_subnet.private2.id
    route_table_id = aws_route_table.private2.id
}

resource "aws_route_table_association" "db-rt1" {
    subnet_id      = aws_subnet.db-sn1.id
    route_table_id = aws_route_table.db-rt.id
}

resource "aws_route_table_association" "db-rt2" {
    subnet_id      = aws_subnet.db-sn2.id
    route_table_id = aws_route_table.db-rt.id
}
