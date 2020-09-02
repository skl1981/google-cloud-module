sudo yum install -y nginx
sudo echo "Hello from S.Shevtsov" > /usr/share/nginx/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx
