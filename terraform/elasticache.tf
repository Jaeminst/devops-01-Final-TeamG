resource "aws_elasticache_subnet_group" "redis" {
  name       = "redis-cache-subnet"
  subnet_ids = [
    aws_subnet.db-sn1.id,
    aws_subnet.db-sn2.id,
    aws_subnet.private1.id,
    aws_subnet.private2.id
  ]
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "superg-redis"
  replication_group_description = "reservation"
  engine                        = "redis"
  engine_version                = "6.x"
  node_type                     = "cache.t3.micro"
  parameter_group_name          = "default.redis6.x.cluster.on"
  port                          = 6379
  apply_immediately             = true
  auto_minor_version_upgrade    = "true"
  maintenance_window            = "tue:06:30-tue:07:30"
  snapshot_window               = "01:00-02:00"
  at_rest_encryption_enabled    = true
  transit_encryption_enabled    = false
  automatic_failover_enabled    = true
  multi_az_enabled              = true

  number_cache_clusters   = 2
  # num_node_groups         = 1
  # replicas_per_node_group = 1

  subnet_group_name  = aws_elasticache_subnet_group.redis.name
  security_group_ids = [aws_security_group.private.id]

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis_slow.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis_engine.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }
}
resource "aws_cloudwatch_log_group" "redis_slow" {
  name = "redis-slow"

  tags = {
    Environment = "dev"
    Application = "reservation-api-server"
  }
}
resource "aws_cloudwatch_log_group" "redis_engine" {
  name = "redis-engine"

  tags = {
    Environment = "dev"
    Application = "reservation-api-server"
  }
}