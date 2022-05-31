#!/bin/bash
source /opt/env_elastic_host
source /opt/env_elastic_pass
source /opt/env_redis_host
source /opt/env_db_endpoint
source /opt/env_db_port
source /opt/env_db_user
source /opt/env_db_pass
source /opt/env_db_use
source /opt/env_server_port
source /opt/env_notify_arn
echo "Inject Variable" >> index.html
echo "<br> Elastic Host: $ELASTIC_HOST" >> index.html
echo "<br> Elastic Pass: $ELASTIC_PASSWORD" >> index.html
echo "<br> Redis Host: $REDIS_HOST" >> index.html
echo "<br> DB Endpoint: $DATABASE_HOST" >> index.html
echo "<br> DB Port: $DATABASE_PORT" >> index.html
echo "<br> DB User: $DATABASE_USERNAME" >> index.html
echo "<br> DB Pass: $DATABASE_PASSWORD" >> index.html
echo "<br> DB use-db: $DATABASE_DB" >> index.html
echo "<br> Notify SQS arn: $NOTIFY_ARN" >> index.html

apt -y update
apt -y install ruby-full
wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install
chmod +x install
./install auto > /tmp/logfile

nohup busybox httpd -h / -f -p 8080 &