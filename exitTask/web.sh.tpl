#!/bin/bash
sudo yum install -y nginx
sudo yum install -y telnet

cat <<EOF > /usr/share/nginx/html/index.html
<html><body><h1>Hello from Dzmitry Kramich</h1>
<p>oh gosh finally</p>
</body></html>
EOF

systemctl enable nginx
systemctl start nginx