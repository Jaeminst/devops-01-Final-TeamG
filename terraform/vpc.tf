resource "aws_vpc" "project4_team" {    
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "project4-asdf"
  }
}

data "aws_availability_zone" "az" {
  name = data.aws_availability_zones.available.names[0]
}

data "aws_availability_zones" "available" {
  state = "available"
}




#서브넷

#vpc그룹

#라우팅 테이블
