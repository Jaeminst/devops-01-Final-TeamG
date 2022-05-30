#!/bin/bash
source /opt/env_elk_version
source /opt/env_elastic_pass
source /opt/env_logstash_pass
source /opt/env_kibana_pass
echo "Inject Variable" >> index.html
echo "<br> Elastic Version: $ELASTIC_VERSION" >> index.html
echo "<br> Elastic Password: $ELASTIC_PASSWORD" >> index.html
echo "<br> Logstash Password: $LOGSTASH_INTERNAL_PASSWORD" >> index.html
echo "<br> Kibana Password: $KIBANA_SYSTEM_PASSWORD" >> index.html

apt -y update
apt -y install ruby-full
wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install
chmod +x install
./install auto > /tmp/logfile

nohup busybox httpd -h / -f -p 8080 &