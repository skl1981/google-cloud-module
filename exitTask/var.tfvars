project       = "compact-retina-288017"
region        = "us-central1"
zone          = "us-central1-c"
machine_type  = "custom-1-4608"
disk_type     = "pd-ssd"
disk_size     = 35
images        = "centos-cloud/centos-7"
ssh_user      = "centos"
ssh_key       = "key.pub"

#network options 
student_name          = "dk"
external_http_ports   = ["80"]
ssh_external_ports    = ["22"]
external_ranges       = ["0.0.0.0/0"]
internal_db_ports     = ["22","5432"]
internal_ranges       = ["10.2.0.0/24"]
public_subnet         = "10.2.1.0/24"
private_subnet        = "10.2.2.0/24"
web_tags              = ["nginx"]
external_ssh_tags     = ["bastion", "nginx"]
db_tags               = ["db-postgres"]

#network for bastion, templates, tcp-lb
network_custom_vpc        = "dk-vpc"
subnetwork_custom_public  = "public-subnet"
subnetwork_custom_private = "private-subnet"

#templates options
distribution_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
http_port          = "80"
db_replicas        = "3"
web_replicas       = "1"

#tcp-lb options
db_port      = "5432"
tcp_lb_ports = ["5432"]
