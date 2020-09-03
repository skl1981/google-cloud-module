#!/bin/bash

sudo yum install nginx -y 
sudo systemctl enable nginx
sudo systemctl start nginx 
sudo echo "<h1>Hello from ${student_name}</h1>" > /usr/share/doc/html/index.html
