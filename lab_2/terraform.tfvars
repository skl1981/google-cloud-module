project_id    = "main-tokenizer-287910"
region        = "us-central1"
zone          = "us-central1-c"
image_project = "centos-cloud"
image_family  = "centos-7"

instance_name = "nginx-terraform"
machine_type  = "n1-custom-1-4608"

network_type  = "default"
network_tags  = ["http-server", "https-server"]

protection    = true

custom_labels = {
  "server_type"       = "nginx_server"
  "os_family"         = "redhat"
  "wayofinstallation" = "terraform"
}
disk_name          = "new-disk"
disk_type          = "pd-ssd"
disk_size_custom   = "35"
disk_size_default  = "20"