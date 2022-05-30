resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project4_team.id
}