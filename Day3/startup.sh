#! /bin/bash
sudo yum -y -q install epel-release
sudo yum -y -q install nginx
sudo systemctl start nginx
sudo echo 'Hello from ${student_name}'  > /usr/share/nginx/html/index.html

