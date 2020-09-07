#!/bin/bash
sudo yum install -y nginx
sudo echo "<h1>Hello from ${studentName} ${studentSurname}</h1>" | sudo tee /usr/share/nginx/html/index.html

sudo systemctl start nginx
sudo systemctl enable nginx