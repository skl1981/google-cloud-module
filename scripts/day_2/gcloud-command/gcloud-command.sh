#!/bin/bash
gcloud compute instances create nginx-gcloud \
        --zone="us-central1-c" \
        --image-family="centos-7" \
        --image-project "centos-cloud" \
        --custom-cpu=1 \
        --custom-memory="4608MiB" \
        --boot-disk-type="pd-ssd" \
        --boot-disk-size="35GB" \
        --deletion-protection \
        --tags "http-server,https-server" \
        --network="default" \
        --labels "servertype=nginxserver,osfamily=redhat,wayofinstallation=gcloud" \
        --metadata-from-file=startup-script="startup.sh" \
        --service-account="terrgc@my-gcloud1.iam.gserviceaccount.com"

