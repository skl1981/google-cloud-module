#!/bin/bash

sudo yum install nginx -y
sudo systemctl start nginx
sudo echo "Hello from ${student_name}" > /usr/share/nginx/html/index.html 
