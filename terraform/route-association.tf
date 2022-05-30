resource "aws_route_table_association" "route_table_public_a" {
    subnet_id      = aws_subnet.public1.id
    route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "route_table_public_b" {
    subnet_id      = aws_subnet.public2.id
    route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "route_table_private_a" {
    subnet_id      = aws_subnet.private1.id
    route_table_id = aws_route_table.route_table_private.id
}

resource "aws_route_table_association" "route_table_private_b" {
    subnet_id      = aws_subnet.private2.id
    route_table_id = aws_route_table.route_table_private.id
}