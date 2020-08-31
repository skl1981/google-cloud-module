#! /bin/bash
sudo yum -y -q install epel-release
sudo yum -y -q install nginx
sudo systemctl start nginx
