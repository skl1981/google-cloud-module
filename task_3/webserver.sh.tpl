sudo yum install -y nginx
cat << EOF > /usr/share/nginx/html/index.html
<html>
<h2>Hello form ${myname}</h2>
</html>
EOF
sudo systemctl start nginx
sudo systemctl enable nginx
