#!/bin/bash
sudo yum install nginx -y
sudo systemctl start nginx
echo 'Hello from ${my_name} ${my_surname}' > /usr/share/nginx/html/index.html