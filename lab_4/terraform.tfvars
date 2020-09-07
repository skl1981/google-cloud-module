project            = "main-tokenizer-287910"
region             = "us-central1"
zone               = "us-central1-c"
ssh_username       = "centos"
ssh_key            = "ssh.pub"

machine_type       = "f1-micro"
image_project      = "centos-cloud"
image_family       = "centos-7"

prefix_web         = "web"
prefix_db          = "db"
web_instance_count = "1"
db_instance_count  = "3"
student_name       = "Kanstantsin"         
student_surname    = "Karpau"     

vpc_net_name                = "vpc-net" 
vpc_net_prefix              = "kkarpau"
subnet_private_name         = "vpc-net-private"
subnet_public_name          = "vpc-net-public"

subnet_private_cidr         = "10.6.2.0/24"
subnet_public_cidr          = "10.6.1.0/24"
net_jumphost_ports          = ["22"]
net_external_allow_ports    = ["22","80"]
net_internal_allow_ports_t  = ["22","5432"]

balancing_ports             = ["5432"]
