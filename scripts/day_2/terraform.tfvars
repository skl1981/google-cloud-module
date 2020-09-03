project="my-gcloud1"
name="nginx-terraform"
region="us-central1"
zone="us-central1-c"
image_family="centos-7"
image_project="centos-cloud"
machine_type="custom-1-4608"
boot_disk_type="pd-ssd"
boot_disk_size="35"
deletion_protection="true"
tag=["http-server","https-server"]
network="default"
label={  "servertype"="nginxserver",
         "osfamily"="redhat",
         "wayofinstallation"="gcloud"}
script="startup-script=startup.sh"
service_account_email="terrgc@my-gcloud1.iam.gserviceaccount.com"
