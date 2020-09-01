name 		 = "nginx-terraform"
zone 		 = "us-central1-c"
machine_type = "custom-1-4608"
disk_size 	 = "35"
disk_type 	 = "pd-ssd"
image 		 = "centos-cloud/centos-7"
tag 		 = ["http-server", "https-server"]
labels 		 = {
  servertype = "nginxserver",
  osfamily = "redhat",
  wayofinstallation = "terraform"
				}
delete 		 = "true"
script 		 = <<SCRIPT
				 sudo yum -y install nginx
				 sudo systemctl start nginx
			   SCRIPT
network 	 = "default" 
