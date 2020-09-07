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
allow_jump_ports   = ["22"]
allow_web_ports    = ["22","80"]
allow_db_ports     = ["22","5432"]


// bastion instance variables
name_instance      = "jump-host"
machine_type       = "custom-1-4608"
image_jump         = "debian-cloud/debian-9"
disk_type          = "pd-ssd"
disk_size_gb       = "20"
ssh_user_name      = "ubuntu"
ssh_key_name       = "key.pub"

// instance group variables
machine_type_db    = "n1-standard-1"
machine_type_web   = "n1-standard-1"
image_web          = "debian-cloud/debian-9"
image_db           = "debian-cloud/debian-9"
base_inst_name_web = "web"
base_inst_name_db  = "db"
count_ins_web      = "1"
count_ins_db       = "3"
web_script         = "script_web.sh.tpl"
db_script          = "script_db.sh"
student_name       = "Siarhei"         //name on the start page
student_surname    = "Hryshchanka"     //surname on the start page
ssh_user_name_for_groups = "ubuntu"
ssh_key_name_for_groups  = "key.pub"

// http lb variables
http_lb_proxy_port = "80"
http_lb_protocol   = "HTTP"
http_lb_hc_port    = "80" 


// interanal lb variables
internal_lb_proxy_port   = ["5432"]
internal_lb_hc_port      = "5432"