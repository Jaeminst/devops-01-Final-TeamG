# devops-01-Final-TeamG-scenario1
TeamG repository

## Secret vars file for Terraform apply
```bash
$ terraform apply -var-file="secret.tfvars"
```

## secret.tfvars
Super Secret file ^-^/

## apply & destroy tfstate unlocking
```bash
$ terraform force-unlock <ID on Lock Info>
```

## Resource Targetting for Modifycation
```bash
$ terraform apply -target=<Resource>

# Example
$ terraform apply -target=aws_alb.elk_server
```

## Apply complete Outputs Example
 * Secret to sensitive

```bash
api_server_elb = "api-server-514967050.ap-northeast-2.elb.amazonaws.com"
api_server_listener_target_port = 3000
cache_configure_endpoint = "superg-redis.sr25la.clustercfg.apn2.cache.amazonaws.com"
db_address = "terraform-20220601052959473200000008.cgv2m6sgcple.ap-northeast-2.rds.amazonaws.com"
db_connect_string = <sensitive>
db_name = <sensitive>
db_port = 3306
elk_server_elb = "elk-server-1070576728.ap-northeast-2.elb.amazonaws.com"
notify_queue_arn = "arn:aws:sqs:ap-northeast-2:104785054338:notify-queue"
```