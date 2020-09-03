#! /bin/bash
sudo yum -y install nginx
sudo echo "Hello from ${student_name}" > /usr/share/nginx/html/index.html
sudo systemctl start nginx
