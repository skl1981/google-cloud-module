#!/bin/bash
gcloud compute instances create nginx-gcloud \
--zone=us-central1-c \
--custom-vm-type n1 \
--custom-cpu=1 \
--custom-memory=4608MB \
--boot-disk-type=pd-ssd \
--boot-disk-size=35GB \
--image=centos-7 \
--tags="http-server","https-server" \
--labels="server_type=nginx_server","os_family=red_hat","way_of_installation=gcloud" \
--deletion-protection \
--metadata startup-script="sudo yum update
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx" \
--network=default 