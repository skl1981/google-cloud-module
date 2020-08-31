#!/bin/bash

gcloud compute instances create nginx-gcloud \
	--zone=us-central1-c \
	--custom-cpu=1 \
	--custom-memory=4608MB \
	--boot-disk-type=pd-ssd \
	--boot-disk-size=35GB \
	--image-project=centos-cloud \
	--image-family=centos-7 \
	--labels=servertype=nginx-gcloudserver,osfamily=redhat,wayofinstallation=gcloud \
	--deletion-protection \
	--tags=http-server,https-server \
	--metadata-from-file startup-script=simplenginx.sh 
	
gcloud compute disks create nginx-disk-gcloud --size=10GB \
  --zone us-central1-c --type=pd-standard 

gcloud compute instances attach-disk nginx-gcloud \
  --disk nginx-disk-gcloud --zone us-central1-c	
	
