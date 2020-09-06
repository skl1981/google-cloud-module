// shared variables
project_id    = "my-day02-project"
region        = "us-central1"
zone          = "us-central1-c"

// network variables
net_name           = "siarhei-hryshchanka" 
sub_priv_name      = "private-subnetwork"
sub_pub_name       = "public-subnetwork"
sub_priv_range     = "10.10.2.0/24"
sub_pub_range      = "10.10.1.0/24"
jump_ports         = ["22"]
web_ports          = ["22","80"]
db_ports           = ["22","5432"]

// bastion instance variables
name_instance      = "jump-host"
machine_type       = "custom-1-4608"
image_project      = "debian-cloud"
image_family       = "debian-9"
disk_type          = "pd-ssd"
disk_size_gb       = "20"

// instance group variables
base_inst_name_web = "web"
base_inst_name_db  = "db"
count_ins_web      = "1"
count_ins_db       = "3"
student_name       = "Siarhei"         //name on the start page
student_surname    = "Hryshchanka"     //surname on the start page

// interanal lb variables
ports_int_lb       = ["5432"]