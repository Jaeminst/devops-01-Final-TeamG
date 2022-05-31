resource "aws_launch_template" "alt" {
  name_prefix = "api"

  image_id = data.aws_ami.ubuntu.id

  network_interfaces {
    device_index                = 0
    ipv4_address_count          = 0
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.public.id, aws_security_group.private.id]
    associate_public_ip_address = true
    delete_on_termination       = true
  }

  instance_type = "t3.micro"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = true
      volume_size = 8
      volume_type = "gp2"
    }
  }

  iam_instance_profile {
    arn = "arn:aws:iam::104785054338:instance-profile/EC2Role"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "project4-ec2"
      EC2Tag = "EC2Tag"
    }
  }

  lifecycle {
    create_before_destroy = true 
  }

  disable_api_termination = false
  ebs_optimized = false
  user_data = data.template_cloudinit_config.config.rendered
  update_default_version = true
}
