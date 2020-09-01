name                = "nginx-terraform"
machine_type        = "n1-custom-1-4608"
zone                = "us-central1-c"
image               = "centos-cloud/centos-7"
size                = "35"
type                = "pd-ssd"
tags                = ["http-server", "https-server"]
servertype          = "nginxserver"
osfamily            = "redhat"
wayofinstall        = "terraform"
deletion_protection = "true"
network             = "default"
labels = {
  servertype        = "nginxserver",
  osfamily          = "redhat",
  wayofinstallation = "terraform"
}
