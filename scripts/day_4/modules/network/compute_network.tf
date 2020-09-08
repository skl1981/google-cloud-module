#---------------------------#
# Create compute network    #
#---------------------------#

resource "google_compute_network" "compute_network" {
    name                        = var.name_network
    description                 = var.description
    project                     = var.project
    auto_create_subnetworks     = var.auto_create_subnetworks
    routing_mode                = var.routing_mode
}

#-------------------------------------#
# Create compute public subnetwork    #
#-------------------------------------#

resource "google_compute_subnetwork" "public_subnet" {
    name                        = var.public_subnet_name
    project                     = var.project
    region                      = var.region
    ip_cidr_range               = var.public_subnet_cidr
    private_ip_google_access    = var.public_ip_google_access
    network                     = google_compute_network.compute_network.id
}

#-------------------------------------#
# Create compute private subnetwork   #
#-------------------------------------#

resource "google_compute_subnetwork" "private_subnet" {
    name                        = var.private_subnet_name
    project                     = var.project
    region                      = var.region
    ip_cidr_range               = var.private_subnet_cidr
    private_ip_google_access    = var.private_ip_google_access
    network                     = google_compute_network.compute_network.id
}

#-------------------------------------#
# Create compute nat network          #
#-------------------------------------#

resource "google_compute_router" "router" {
  name                          = var.router_name
  region                        = var.region
  network                       = google_compute_network.compute_network.id
}

resource "google_compute_router_nat" "nat" {
  name                          = var.nat_name
  router                        = google_compute_router.router.name
  nat_ip_allocate_option        = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}


#---------------------------------------------#
# Create compute firewall bastion rules       #
#---------------------------------------------#

resource "google_compute_firewall" "allow-ssh" {
    name                    	= var.ssh_rule
    project                 	= var.project
    network                 	= google_compute_network.compute_network.name
    priority                	= var.priority_ssh
    description             	= var.description_ssh_rule
    direction               	= var.direction
    allow {
        protocol              	= var.ssh_protocol
        ports                 	= var.ssh_ports
    }
    target_tags             	= var.allow_ssh_tags
    source_tags             	= var.ssh_tags
}

resource "google_compute_firewall" "allow-jump" {
    name                    	= var.jump_rules
    project                 	= var.project
    network                 	= google_compute_network.compute_network.name
    priority                	= var.priority_jump
    description             	= var.description_jump_rule
    direction               	= var.direction   
    allow {
        protocol            	= var.jump_protocol
        ports               	= var.jump_port
     }
    target_tags             	= var.jump_tag
    source_ranges           	= var.jump_ip    
}


resource "google_compute_firewall" "deny-internal" {
    name                    	= var.deny_rule
    project                 	= var.project
    network                 	= google_compute_network.compute_network.name
    priority                	= "1001"
    description             	= var.description_deny_rule
    direction               	= var.direction
    deny {
        protocol            	= var.deny_protocol
        ports               	= var.deny_port
    }
    target_tags             	= var.deny_tags
    source_ranges             	= ["0.0.0.0/0"]
}

#---------------------------------------------#
# Create compute firewall postgress rules     #
#---------------------------------------------#

resource "google_compute_firewall" "allow-db" {
    name                    	= var.db_rule
    project                 	= var.project
    network                 	= google_compute_network.compute_network.name
    priority                	= var.priority_db
    description             	= var.description_db_rule
    direction               	= var.direction
    allow {
        protocol            	= var.db_protocol
        ports               	= var.db_port
    }
    source_tags             	= var.nginx_tag
    target_tags             	= var.db_tag 
}

#---------------------------------------------#
# Create compute firewall nginx rules         #
#---------------------------------------------#

resource "google_compute_firewall" "allow-http" {
    name                    	= var.http_rule
    project                 	= var.project
    network                 	= google_compute_network.compute_network.name
    priority                	= var.priority_http
    description             	= var.description_http_rule
    direction               	= var.direction
    allow {
        protocol               	= var.http_protocol
        ports                  	= var.http_port
    }
    target_tags             	= var.nginx_tag 
}

#----------------------------------------------------#
# Create compute firewall health-check rules         #
#----------------------------------------------------#

resource "google_compute_firewall" "allow-public-health-check" {
    name                    	= var.public_health_check_rule
    project                 	= var.project
    network                 	= google_compute_network.compute_network.name
    priority                	= var.priority_public_health_check
    description             	= var.description_health_public_check_rule
    direction               	= var.direction
    allow {
        protocol            	= var.public_health_check_protocol
        ports               	= var.public_health_check_port
    }
    source_ranges           	= var.public_health_check_ip
    target_tags             	= var.nginx_tag
}

resource "google_compute_firewall" "allow-private-health-check" {
    name                    	= var.private_health_check_rule
    project                 	= var.project
    network                 	= google_compute_network.compute_network.name
    priority                	= var.priority_private_health_check
    description             	= var.description_health_private_check_rule
    direction               	= var.direction
    allow {
        protocol            	= var.private_health_check_protocol
        ports               	= var.private_health_check_port
    }
    source_ranges           	= var.health_private_check_ip
    target_tags             	= var.db_tag
}


