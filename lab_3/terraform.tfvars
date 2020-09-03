project          = "main-tokenizer-287910"
instance_region  = "us-central1"
instance_zone    = "us-central1-c"
instance_name    = "terraform-task5"
machine_type     = "n1-custom-1-4608"
image_project    = "centos-cloud"
image_family     = "centos-7"

student_name     = "kkarpau"
student_IDnum    = "6"

instance_allow_stopping_for_upd = true

vpc_net_external_name           = "external-firewall-rule"
vpc_net_external_allow_protocol = "tcp"
vpc_net_external_allow_ports    = ["80", "22"]
vpc_net_external_source_ranges  = ["0.0.0.0/0"]

vpc_net_internal_name             = "internal-firewall-rule"
vpc_net_internal_allow_protocol_t = "tcp"
vpc_net_internal_allow_protocol_u = "udp"
vpc_net_internal_allow_protocol_a = "icmp" # how 2 set type=list
vpc_net_internal_allow_ports_t    = ["0-65535"]
vpc_net_internal_allow_ports_u    = ["0-65535"]
vpc_net_internal_source_ranges    = ["10.6.0.0/16"]

vpc_subnet_public_name            = "vpc-public-subnet"
vpc_subnet_public_ip_cidr_range   = "10.6.1.0/24"

vpc_subnet_private_name           = "vpc-private-subnet"
vpc_subnet_private_ip_cidr_range  = "10.6.2.0/24"