#! /bin/bash
sudo yum -y install nginx
sudo echo "Hello from ${studentName} ${studentSurname}!" > /usr/share/nginx/html/index.html
sudo systemctl start nginx