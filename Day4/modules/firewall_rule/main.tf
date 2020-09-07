resource "google_compute_firewall" "ingress_ssh_allow_jump_host" {
name   					          = var.mod_ingress_ssh_allow_jump_host_name 
network 				          = var.mod_firewall_network_name
source_ranges		          = var.mod_ingress_ssh_jump_host_source_ranges 
target_tags               = [var.mod_firewall_tag_jump_host]

  allow {
    protocol = var.mod_firewall_protocol_tcp
    ports    = var.mod_firewall_ports_ssh
  }

  allow {
    protocol = var.mod_firewall_protocol_udp
    ports    = var.mod_firewall_ports_ssh
  }

  allow {
    protocol = var.mod_firewall_protocol_sctp
    ports    = var.mod_firewall_ports_ssh
  }
}

resource "google_compute_firewall" "ingress_ssh_deny_from_vms" {
name   					          = var.mod_ingress_ssh_deny_from_vms_name
network 				          = var.mod_firewall_network_name
source_tags               = [var.mod_firewall_tag_web_server, var.mod_firewall_tag_database_server]

  deny {
    protocol = var.mod_firewall_protocol_tcp
    ports    = var.mod_firewall_ports_ssh
  }

  deny {
    protocol = var.mod_firewall_protocol_udp
    ports    = var.mod_firewall_ports_ssh
  }

  deny {
    protocol = var.mod_firewall_protocol_sctp
    ports    = var.mod_firewall_ports_ssh
  }
}

resource "google_compute_firewall" "ingress_ssh_vms" {
name   					          = var.mod_ingress_ssh_name 
network 				          = var.mod_firewall_network_name
source_tags               = [var.mod_firewall_tag_jump_host]
target_tags               = [var.mod_firewall_tag_web_server, var.mod_firewall_tag_database_server]
  
  allow {
    protocol = var.mod_firewall_protocol_tcp
    ports    = var.mod_firewall_ports_ssh
  }

  allow {
    protocol = var.mod_firewall_protocol_udp
    ports    = var.mod_firewall_ports_ssh
  }

  allow {
    protocol = var.mod_firewall_protocol_sctp
    ports    = var.mod_firewall_ports_ssh
  }
}

resource "google_compute_firewall" "ingress_http" {
name   					          = var.mod_ingress_http_name
network 				          = var.mod_firewall_network_name
target_tags               = [var.mod_firewall_tag_web_server]

  allow {
    protocol = var.mod_firewall_protocol_tcp
    ports    = var.mod_firewall_ports_http
  }
}

resource "google_compute_firewall" "ingress_db" {
name   					          = var.mod_ingress_db_name
network 				          = var.mod_firewall_network_name
target_tags               = [var.mod_firewall_tag_database_server]

  allow {
    protocol = var.mod_firewall_protocol_tcp
    ports    = var.mod_firewall_ports_db
  }
}