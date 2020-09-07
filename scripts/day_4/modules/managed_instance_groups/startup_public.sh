#!/bin/bash
sudo apt update && sudo apt install -y nginx 
sudo systemctl enable nginx
sudo systemctl start nginx 
sudo sh -c 'echo "<h1>Hello from ${student_name} ${student_surname}!</h1>" > /usr/share/nginx/html/index.html'
