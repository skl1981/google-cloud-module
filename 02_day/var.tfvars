project_id    = "my-day02-project"
region        = "us-central1"
zone          = "us-central1-c"
name_instance = "nginx-terraform-day2"
machine_type  = "custom-1-4608"
image_project = "centos-cloud"
image_family  = "centos-7"
disk_type     = "pd-ssd"
disk_size_gb  = "35"
tags          = ["http-server", "https-server"]
labels        = {servertype="nginxserver",osfamily="redhat",wayofinstallation="terraform"}
delete        = true