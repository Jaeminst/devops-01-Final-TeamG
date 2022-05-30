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
    echo 'DATABASE_HOST="${aws_db_instance.mysql.address}"' >> /opt/env_db_endpoint
    echo 'DATABASE_PORT="${var.rds_port}"' >> /opt/env_db_port
    echo 'DATABASE_USERNAME="${aws_db_instance.mysql.username}"' >> /opt/env_db_user
    echo 'DATABASE_PASSWORD="${aws_db_instance.mysql.password}"' >> /opt/env_db_pass
    echo 'server_port="${var.server_port}"' >> /opt/env_server_port
    EOF
  }
  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.client.rendered
  }
}