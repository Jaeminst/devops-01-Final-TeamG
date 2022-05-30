output "ElasticSearch_DNS" {
  description = "ElasticSearch"
  value       = "http://${aws_alb.elk_server.dns_name}:9200"
}
output "Logstash_endpoint" {
  description = "ElasticSearch"
  value       = "http://${aws_alb.elk_server.dns_name}:4055"
}
output "Kibana_DNS" {
  description = "ElasticSearch"
  value       = "http://${aws_alb.elk_server.dns_name}:5601"
}

output "server_port" {
  description = "Connect to the EC2 at this port"
  value       = var.server_port
}

output "server_elb" {
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

output "cache_host" {
  description = "ElastiCache connection host"
  value       = aws_elasticache_cluster.teamg.cluster_address
}