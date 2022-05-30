output "ElasticSearch_DNS" {
  description = "ElasticSearch"
  value = "http://${aws_instance.docker_elk.public_dns}:9200"
}
output "Logstash_endpoint" {
  description = "ElasticSearch"
  value = "http://${aws_instance.docker_elk.public_dns}:4055"
}
output "Kibana_DNS" {
  description = "ElasticSearch"
  value = "http://${aws_instance.docker_elk.public_dns}:5601"
}