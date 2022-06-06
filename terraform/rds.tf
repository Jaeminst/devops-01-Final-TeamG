locals {
  multi_az = {
    true = ""
    false = "${data.aws_availability_zones.available.names[0]}"
  }
}

resource "aws_db_instance" "mysql" {
  engine               = "mysql"
  engine_version       = "5.7"
  name                 = var.db_use_data
  username             = var.db_username
  password             = var.db_password
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  db_subnet_group_name = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.private.id]
  skip_final_snapshot  = true

  # Selection multi_az True is Don't AZ setup
  multi_az             = var.multi_az
  availability_zone    = lookup(local.multi_az, var.multi_az)
  
  # Optional and default
  max_allocated_storage = 0
  license_model         = "general-public-license"
  port                  = var.rds_port
  publicly_accessible   = false
  storage_encrypted     = false
  storage_type          = "gp2"
  parameter_group_name  = "default.mysql5.7"
}
