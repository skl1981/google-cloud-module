#!/bin/bash
sudo yum install -y nginx
sudo echo "Hello from ${student_name}" > /usr/share/nginx/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx
