#!/bin/bash
# Installs nginx and enable
sudo apt-get install nginx -y && sudo systemctl start nginx && sudo systemctl enable nginx

sudo echo "<h1>Hello from ${name} ${surname}</h1>" > /var/www/html/index.nginx-debian.html
