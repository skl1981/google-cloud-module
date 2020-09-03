#! /bin/bash
sudo yum -y install nginx && sudo systemctl start nginx && sudo systemctl enable nginx
sudo echo "<h1>Hello from ${student_name}</h1>" > /usr/share/nginx/html/index.html