#!/bin/sh
sudo apt update
sudo apt install ruby-full
sudo apt install wget
wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install

chmod +x ./install
sudo ./install auto