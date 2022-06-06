resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "db-nat-gateway-1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}