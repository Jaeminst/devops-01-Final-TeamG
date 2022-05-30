resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.selected.id
}