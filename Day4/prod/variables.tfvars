vpc_name                            = "vpc-us-central"
vpc_auto_create_subnetworks         = "false"
region                              = "us-central1"
studentName                         = "Dzmitry"
studentSurname                      = "Mezhva"  
ssh_user                            = "centos"
ssh_key                             = "key.pub"
                          
subnetwork_names                    = {
    0 = "subnetwork-private"
    1 = "subnetwork-public"
}
subnetwork_ip_ranges                = {
    0 = "10.3.2.0/24"
    1 = "10.3.1.0/24"
}

jump_host_name                      = "jump-host"
jump_host_type                      = "custom-1-4608"
jump_host_zone                      = "us-central1-c"
jump_host_image                     = "centos-cloud/centos-7"
jump_host_subnetwork                = "subnetwork-public"
jump_host_tags                      = "jump-host"

router_name                         = "router"

nat_name                            = "nat"
nat_ip_option                       = "AUTO_ONLY"
nat_subnetwork_ip_ranges            = "ALL_SUBNETWORKS_ALL_IP_RANGES"

firewall_protocol_tcp               = "tcp"
firewall_protocol_udp               = "udp"
firewall_protocol_sctp              = "sctp"
firewall_ports_ssh                  = ["22"]
firewall_ports_http                 = ["80"]
firewall_ports_db                   = ["5432"]
firewall_tag_web_server             = "web-server"
firewall_tag_database_server        = "database-server"
ingress_ssh_allow_jump_host_name    = "firewall-ingress-ssh-allow-jump-host"
ingress_ssh_jump_host_source_ranges = ["0.0.0.0/0"]
ingress_ssh_deny_from_vms_name      = "firewall-ingress-ssh-deny-from-vms"
ingress_ssh_name                    = "firewall-ingress-ssh-vms"
ingress_http_name                   = "firewall-ingress-http"
ingress_db_name                     = "firewall-ingress-db"


nginx_template_prefix               = "instance-template-nginx"        
nginx_template_tags                 = "web-server"      
nginx_mig_name                      = "nginx-mig" 
nginx_mig_zone_a                    = "us-central1-a"
nginx_mig_zone_b                    = "us-central1-b"
nginx_mig_zone_c                    = "us-central1-c"
nginx_mig_target_size               = "1"         
nginx_scaler_name                   = "nginx-scaler"
nginx_scaler_min_rep                = "1"         
nginx_scaler_max_rep                = "3"         
nginx_scaler_cool_per               = "60"          
nginx_scaler_target                 = "0.6"

db_template_prefix                  = "instance-template-db"      
db_template_tags                    = "database-server"      
db_host_subnetwork                  = "subnetwork-private"      
db_mig_name                         = "db-mig"  
db_mig_target_size                  = "3"      

http_lb_hc_name                     = "http-lb-health-check"
http_lb_bk_name                     = "http-lb-backend-service"
http_lb_map_name                    = "http-lb-map"    
http_lb_proxy_name                  = "http-lb-proxy"  
http_lb_forw_rule_name              = "http-lb-forw-rule"      
http_lb_forw_rule_port_range        = "80"                

int_lb_hc_name                      = "int-lb-health-check"
int_lb_hc_port                      = "5432"
int_lb_bk_name                      = "int-lb-backend-service"
int_lb_forw_rule_name               = "int-lb-forw-rule"
int_lb_forw_rule_scheme             = "INTERNAL"
int_lb_forw_rule_ports              = ["5432"]
