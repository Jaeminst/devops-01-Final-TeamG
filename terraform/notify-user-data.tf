data "template_file" "notify" {
  template = file("./notify-user-data.sh")
}
data "template_cloudinit_config" "notify" {
  gzip          = false
  base64_encode = true
  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    echo 'export AWS_ACCESS_KEY_ID="${var.AWS_ACCESS_KEY_ID}"' >> /opt/env_access_key
    echo 'export AWS_SECRET_ACCESS_KEY="${var.AWS_SECRET_ACCESS_KEY}"' >> /opt/env_secret_key
    echo 'export NOTIFY_QUEUE_URL="${aws_sqs_queue.notify.url}"' >> /opt/env_notify_url
    EOF
  }
  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.notify.rendered
  }
}
