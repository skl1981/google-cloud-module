#!/bin/bash
sudo yum install nginx -y
sudo systemctl start nginx
echo 'Hello from ${student_name}' > /usr/share/nginx/html/index.html