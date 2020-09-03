project = "compact-retina-288017"
region = "us-central1"
zone = "us-central1-c"

# options for vm
name = "nginx-gcp-terraform" 
delete = true
type = "custom-1-4608"

# vm's disk
disk_size = 35
disk_type = "pd-ssd"
disk_image = "centos-7"

# vm's network
network_type = "default"
tags = ["http-server", "https-server"]

# vm's labels
labels = {servertype="nginxserver",osfamily="redhat",wayofinstallation="terraform"}

# persistent_disk's options
persistent_disk_name = "nginx-disk-terraform"
persistent_disk_size = 10
persistent_disk_type = "pd-standard"