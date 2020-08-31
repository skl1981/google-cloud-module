#!/bin/bash

sudo yum install -y nginx

cat <<EOF > /usr/share/nginx/html/index.html
<html><body><h1>Hey. You are here!</h1>
<p>This page was created from simplenginx.sh .</p>
</body></html>
EOF

systemctl enable nginx
systemctl start nginx
