#!/bin/bash

gcloud compute instances create nginx-gcloud \
        --zone=us-central1-c \
        --custom-vm-type=n1 \
        --custom-cpu=1 \
        --custom-memory=4608MB \
        --boot-disk-size=35GB \
        --boot-disk-type=pd-ssd \
        --image-family=centos-7 \
        --image-project=centos-cloud \
        --tags=http-server,https-server \
        --labels=servertype=nginxserver,osfamily=redhat,wayofinstalation=gcloud \
        --deletion-protection \
        --metadata startup-script="sudo yum update
                                  sudo yum install nginx -y 
                                  sudo systemctl start nginx" 
