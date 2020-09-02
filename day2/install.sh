sudo yum update
sudo yum install -y nginx
sudo echo "PRIVET my nginx" > /usr/share/nginx/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx

