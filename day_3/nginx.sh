#!/bin/bash
sudo yum install -y nginx

cat <<EOF > /usr/share/nginx/html/index.html
<html><body><h1>!!!DONE!!!</h1>
</body></html>
EOF

systemctl enable nginx
systemctl start nginx
