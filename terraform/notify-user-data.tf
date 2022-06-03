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
    echo 'export NOTIFY_QUEUE_URL="${aws_sqs_queue.notify.url}"' >> /opt/env_notify_url
    EOF
    # ec2의 iam role을 사용하여 자동으로 자격을 증명합니다.
    # echo 'export AWS_ACCESS_KEY_ID="${var.AWS_ACCESS_KEY_ID}"' >> /opt/env_access_key
    # echo 'export AWS_SECRET_ACCESS_KEY="${var.AWS_SECRET_ACCESS_KEY}"' >> /opt/env_secret_key
  }
  #second part
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.notify.rendered
  }
}
