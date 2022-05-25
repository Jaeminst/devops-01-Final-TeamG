resource "aws_vpc" "project4-teamG" {    
  cidr_block           = cidrsubnet("172.16.0.0/12", 4, var.region_number[data.aws_availability_zone.az.region]) #"172.18.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "project4-teamG"
  }
}

data "aws_availability_zone" "az" {
  name = data.aws_availability_zones.available.names[0]
}

data "aws_availability_zones" "available" {
  state = "available"
}
