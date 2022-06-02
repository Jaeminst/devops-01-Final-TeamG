data "template_file" "client" {
  template = file("./user-data.sh")
}
data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = true
  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    echo 'export ELASTIC_HOST="${aws_alb.elk_server.dns_name}"' >> /opt/env_elastic_host
    echo 'export ELASTIC_PASSWORD="${var.elastic_password}"' >> /opt/env_elastic_pass
    echo 'export REDIS_HOST="${aws_elasticache_replication_group.redis.configuration_endpoint_address}"' >> /opt/env_redis_host
    echo 'export DATABASE_HOST="${aws_db_instance.mysql.address}"' >> /opt/env_db_endpoint
    echo 'export DATABASE_PORT="${var.rds_port}"' >> /opt/env_db_port
    echo 'export DATABASE_USERNAME="${aws_db_instance.mysql.username}"' >> /opt/env_db_user
    echo 'export DATABASE_PASSWORD="${aws_db_instance.mysql.password}"' >> /opt/env_db_pass
    echo 'export DATABASE_DB="${aws_db_instance.mysql.name}"' >> /opt/env_db_use
    echo 'export server_port="${var.server_port}"' >> /opt/env_server_port
    echo 'export AWS_ACCESS_KEY_ID="${var.AWS_ACCESS_KEY_ID}"' >> /opt/env_access_key
    echo 'export AWS_SECRET_ACCESS_KEY="${var.AWS_SECRET_ACCESS_KEY}"' >> /opt/env_secret_key
    echo 'export NOTIFY_ARN="${aws_sqs_queue.notify.arn}"' >> /opt/env_notify_arn
    EOF
  }
  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.client.rendered
  }
  depends_on = [
    aws_elasticache_replication_group.redis
  ]
}
