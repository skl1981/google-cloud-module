name = "nginx-terraform"
machine_type ="custom-1-4608-ext"
zone = "us-central1-c"
tags = ["http-server","https-server"] 
image ="centos-cloud/centos-7"
labels = {
servertype = "nginxserver",
osfamily = "redhat",
wayofinstallation = "terraform"
}
network ="default" 
size = "35"
disk_type ="pd-ssd" 
deletion ="true"
script = <<SCRIPT
sudo yum -y -q install epel-release
sudo yum -y -q install nginx
sudo systemctl start nginx
SCRIPT
