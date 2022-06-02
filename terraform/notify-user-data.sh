#!/bin/bash
source /opt/env_access_key
source /opt/env_secret_key
source /opt/env_notify_url
echo "Inject Variable" >> index.html
echo "<br> AWS_ACCESS_KEY_ID: Super secret" >> index.html
echo "<br> AWS_SECRET_ACCESS_KEY: Super secret" >> index.html
echo "<br> NOTIFY_QUEUE_URL: $NOTIFY_QUEUE_URL" >> index.html

apt -y update
apt -y install ruby-full
wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install
chmod +x install
./install auto > /tmp/logfile

nohup busybox httpd -h / -f -p 8080 &