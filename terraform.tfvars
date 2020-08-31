project       = "devops-lab-summer"
region        = "us-central1"
zone          = "us-central1-c"
creation-way  = "terraform"
network       = "default"
allow_ports   = ["80", "443"]
network_tags  = ["http-server", "https-server"]
machine_type  = "custom-1-4608"
image_project = "centos-cloud"
image_family  = "centos-7"
disk_size_gb  = "35"
pd_size       = "200"
labels = {
  "server_type" = "nginx_server"
  "os_family"   = "redhat"
}
