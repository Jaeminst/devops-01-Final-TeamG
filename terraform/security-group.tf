resource "aws_security_group" "default" {
    name        = "default terraform VPC"
    description = "default VPC security group"
    vpc_id      = data.aws_vpc.selected.id

    tags = {
        Name = "default-terraform"
    }

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = []
        self            = true
    }
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "public" {
  name        = "public-sg"
  description = "Control reservation api inbound and outbound access"
  vpc_id      = data.aws_vpc.selected.id
  tags        = { Name = "reservation-api" }

  ingress { #frontend input
      from_port       = var.server_port
      to_port         = var.server_port
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress { #SSH
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress { #HTTP
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress { #HTTPS
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  egress { #HTTP
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  egress { #HTTPS
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  egress { #RDS_MySQL
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      cidr_blocks     = [
          aws_subnet.db-sn1.cidr_block,
          aws_subnet.db-sn2.cidr_block
      ]
  }
  egress { #ElasticSearch
      from_port       = 9200
      to_port         = 9200
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  egress { #Logstash
      from_port       = 5000
      to_port         = 5000
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }
  egress { #ElastiCache
      from_port       = 6379
      to_port         = 6379
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private" {
  name        = "private-sg"
  description = "Allow access to the RDS database instance"
  vpc_id      = data.aws_vpc.selected.id
  tags        = { Name = "reservation-RDS" }

  ingress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = []
      self            = true
  }
  ingress {
      from_port       = var.rds_port
      to_port         = var.rds_port
      protocol        = "tcp"
      security_groups = [aws_security_group.public.id]
      self            = false
  }
  egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "elk" {
  name        = "elk"
  description = "Allow ELK stack inbound traffic"
  vpc_id      = aws_vpc.project4.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "elasticsearch"
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "kibana"
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"    # any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "elk"
  }
}