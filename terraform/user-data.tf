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
    echo 'REDIS_HOST="${aws_elasticache_replication_group.redis.configuration_endpoint_address}"' >> /opt/env_redis_host
    echo 'DATABASE_HOST="${aws_db_instance.mysql.address}"' >> /opt/env_db_endpoint
    echo 'DATABASE_PORT="${var.rds_port}"' >> /opt/env_db_port
    echo 'DATABASE_USERNAME="${aws_db_instance.mysql.username}"' >> /opt/env_db_user
    echo 'DATABASE_PASSWORD="${aws_db_instance.mysql.password}"' >> /opt/env_db_pass
    echo 'DATABASE_DB="${aws_db_instance.mysql.name}"' >> /opt/env_db_use
    echo 'server_port="${var.server_port}"' >> /opt/env_server_port
    echo 'NOTIFY_ARN="${aws_sqs_queue.notify.arn}"' >> /opt/env_notify_arn
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
