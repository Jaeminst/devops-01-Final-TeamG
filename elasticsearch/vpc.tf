resource "aws_vpc" "project4_elk" {    
  cidr_block           = "172.18.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "project4-elk"
  }
}

data "aws_availability_zone" "az" {
  name = data.aws_availability_zones.available.names[0]
}

data "aws_availability_zones" "available" {
  state = "available"
}
