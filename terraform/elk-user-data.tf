data "template_file" "elk" {
  template = file("./elk-user-data.sh")
}
data "template_cloudinit_config" "elk" {
  gzip          = false
  base64_encode = true
  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    echo 'ELASTIC_VERSION="${var.elk_version}"' >> /opt/env_elk_version
    echo 'ELASTIC_PASSWORD="${var.elastic_password}"' >> /opt/env_elastic_pass
    echo 'LOGSTASH_INTERNAL_PASSWORD="${var.logstash_password}"' >> /opt/env_logstash_pass
    echo 'KIBANA_SYSTEM_PASSWORD="${var.kibana_password}"' >> /opt/env_kibana_pass
    EOF
  }
  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.elk.rendered
  }
}
