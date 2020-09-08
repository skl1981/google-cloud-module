#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1>Hello from ${name} ${surname}</h1>" > /usr/share/nginx/html/index.html