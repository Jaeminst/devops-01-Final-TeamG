resource "aws_instance" "docker_elk"{
    ami = "ami-08d0e13d30abef253"
    instance_type = "t3.medium"
    # key_name = "MyKeyPair2"
    subnet_id = aws_subnet.public_sub_es_a.id
    vpc_security_group_ids = [ aws_security_group.elk.id ]
    associate_public_ip_address = true
    user_data = file("./user_data.sh")
    lifecycle{
        create_before_destroy = true
    }
    tags = {
        "Name" = "docker-elk-instance"
    }
}