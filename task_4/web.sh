sudo yum install -y nginx postgresql
cat << EOF > /usr/share/nginx/html/index.html
<html>
<h2>Hello from ${studentName} ${studentSurname}</h2>
</html>
EOF
sudo systemctl start nginx
sudo systemctl enable nginx