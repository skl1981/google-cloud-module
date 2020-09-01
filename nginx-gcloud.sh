#! /bin/bash
gcloud compute instances create nginx-gcloud \
 --image-family=centos-7         \
 --image-project=centos-cloud    \
 --zone=us-central1-c            \
 --labels=servertype=nginxserver,osfamily=redhat,wayofinstallation=gcloud \
 --custom-cpu=1                  \
 --custom-memory=4608MB          \
 --network default               \
 --boot-disk-type=pd-ssd         \
 --boot-disk-size=35GB           \
 --tags=http-server,https-server \
 --deletion-protection           \
 --metadata startup-script='#! /bin/bash
 sudo yum -y install nginx && sudo systemctl start nginx && sudo systemctl enable nginx'
