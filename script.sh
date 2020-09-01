sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo echo "hello from victor's Nginx" > /usr/share/nginx/html/index.html
