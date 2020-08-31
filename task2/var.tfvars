project = "compact-retina-288017"
region = "us-central1"
zone = "us-central1-c"
name = "nginx-gcp-terraform" 
delete = true
type = "custom-1-4608"
disk_size = 35
disk_type = "pd-ssd"
disk_image = "centos-7"
network_type = "default"
tags = ["http-server", "https-server"]
labels = {servertype="nginxserver",osfamily="redhat",wayofinstallation="terraform"}
persistent_disk_name = "nginx-disk-terraform"
persistent_disk_size = 10
persistent_disk_type = "pd-standard"