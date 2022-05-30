resource "aws_route_table" "public" {
    vpc_id = data.aws_vpc.selected.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public-route-table"
    }
}

resource "aws_route_table" "private1" {
    vpc_id = data.aws_vpc.selected.id
    tags = {
        Name = "private-route-table-1"
    }
}

resource "aws_route_table" "private2" {
    vpc_id = data.aws_vpc.selected.id
    tags = {
       Name = "private-route-table-2"
   }
}

resource "aws_route_table" "db-rt" {
    vpc_id = data.aws_vpc.selected.id
    route {
        cidr_block = cidrsubnet("${data.aws_vpc.selected.cidr_block}", 4, 4)
        nat_gateway_id = aws_nat_gateway.nat1.id
    }
    route {
        cidr_block = cidrsubnet("${data.aws_vpc.selected.cidr_block}", 4, 5)
        nat_gateway_id = aws_nat_gateway.nat1.id
    }
    tags = {
       Name = "db-rt"
   }
}
