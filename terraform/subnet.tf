resource "aws_subnet" "public1" {
    vpc_id                  = data.aws_vpc.selected.id
    cidr_block              = cidrsubnet("${data.aws_vpc.selected.cidr_block}", 4, 0) #"172.18.0.0/20"
    availability_zone       = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    tags = {
        Name = "public-az-1"
    }
}

resource "aws_subnet" "private1" {
    vpc_id                  = data.aws_vpc.selected.id
    cidr_block              = cidrsubnet("${data.aws_vpc.selected.cidr_block}", 4, 2) #"172.18.32.0/20"
    availability_zone       = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = false
    tags = {
        Name = "private-az-1"
    }
}

resource "aws_subnet" "public2" {
    vpc_id                  = data.aws_vpc.selected.id
    cidr_block              = cidrsubnet("${data.aws_vpc.selected.cidr_block}", 4, 1) #"172.18.16.0/20"
    availability_zone       = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    tags = {
        Name = "public-az-2"
    }
}

resource "aws_subnet" "private2" {
    vpc_id                  = data.aws_vpc.selected.id
    cidr_block              = cidrsubnet("${data.aws_vpc.selected.cidr_block}", 4, 3) #"172.18.48.0/20"
    availability_zone       = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = false
    tags = {
        Name = "private-az-2"
    }
}

resource "aws_subnet" "db-sn1" {
    vpc_id                  = data.aws_vpc.selected.id
    cidr_block              = cidrsubnet("${data.aws_vpc.selected.cidr_block}", 4, 4) #"172.18.64.0/20"
    availability_zone       = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = false
    tags = {
        Name = "db-sn-az-1"
    }
}

resource "aws_subnet" "db-sn2" {
    vpc_id                  = data.aws_vpc.selected.id
    cidr_block              = cidrsubnet("${data.aws_vpc.selected.cidr_block}", 4, 5) #"172.18.80.0/20"
    availability_zone       = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = false
    tags = {
        Name = "db-sn-az-2"
    }
}

resource "aws_db_subnet_group" "mysql" {
  name       = "db-subnet-group"
  subnet_ids = [
    aws_subnet.db-sn1.id,
    aws_subnet.db-sn2.id,
    aws_subnet.private1.id,
    aws_subnet.private2.id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}