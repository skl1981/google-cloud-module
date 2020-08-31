gcloud compute instances create nginx --project devops-lab-summer --zone us-central1-c \
--network default --machine-type custom-1-4608 --image-project centos-cloud --image-family centos-7 \
--boot-disk-size 35 --labels server_type=nginx_server,os_family=redhat,way_of_installation=gcloud \
--deletion-protection --metadata-from-file startup-script=webserver.sh \
--tags=http-server,https-server
