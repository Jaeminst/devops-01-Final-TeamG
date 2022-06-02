output "elk_server_elb" {
  description = "Connect to the EC2 at this dns_name"
  value       = aws_alb.elk_server.dns_name
}

output "api_server_listener_target_port" {
  description = "Connect to the EC2 at this target port"
  value       = var.server_port
}
output "api_server_elb" {
  description = "Connect to the EC2 at this dns_name"
  value       = aws_alb.api_server.dns_name
}

output "db_port" {
  description = "Connect to the database at this port"
  value       = var.rds_port
}
output "db_address" {
  description = "Connect to the database at this address"
  value       = aws_db_instance.mysql.address
}
output "db_name" {
  description = "Connect to the database at this name"
  value       = aws_db_instance.mysql.name
  sensitive   = true
}
output "db_connect_string" {
  description = "MySQL database connection string"
  value       = "Server=${aws_db_instance.mysql.address}; Database=ExampleDB; Uid=${var.db_username}; Pwd=${var.db_password}"
  sensitive   = true
}

output "cache_primary_endpoint" {
  description = "ElastiCache connection Primary"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}
output "cache_reader_endpoint" {
  description = "ElastiCache connection Reader"
  value       = aws_elasticache_replication_group.redis.reader_endpoint_address
}
output "cache_configure_endpoint" {
  description = "ElastiCache connection Configure"
  value       = aws_elasticache_replication_group.redis.configuration_endpoint_address
}

output "notify_queue_arn" {
  description = "SQS arn for Notify Server"
  value       = aws_sqs_queue.notify.arn
}

output "notify_queue_url" {
  description = "SQS url for Notify Server"
  value       = aws_sqs_queue.notify.url
}