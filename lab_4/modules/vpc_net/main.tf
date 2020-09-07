resource "google_compute_network" "vpc_net" {
  name                    = var.vpc_net
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet_public" {
  name          = var.subnet_public_name
  region        = var.region
  ip_cidr_range = var.subnet_public_ip_cidr_range
  network       = google_compute_network.vpc_net.id
  description   = "Create Public Subnet"
}

resource "google_compute_subnetwork" "vpc_subnet_private" {
  name          = var.subnet_private_name
  region        = var.region
  ip_cidr_range = var.subnet_private_ip_cidr_range
  private_ip_google_access = true
  network       = google_compute_network.vpc_net.id
  description   = "Create Private Subnet"
}

resource "google_compute_firewall" "external-firewall" {
  name          = "${var.prefix}-external-firewall-rule"
  network       = google_compute_network.vpc_net.id
  description   = "Create Firewall rules for external Network"  
  allow {
    protocol    = var.net_external_allow_protocol
    ports       = var.net_external_allow_ports
  }
  source_ranges = var.net_external_source_ranges
  target_tags   = var.net_jumphost_tags
}

resource "google_compute_firewall" "internal-firewall" {
  name          = "${var.prefix}-internal-firewall-rule"
  network       = google_compute_network.vpc_net.id
  description   = "Create Firewall rules for internal Network"
  allow {
    ports       = var.net_internal_allow_ports_t
    protocol    = var.net_internal_allow_protocol_t
    }
  allow {
    ports       = var.net_internal_allow_ports_u
    protocol    = var.net_internal_allow_protocol_u
    }
  allow {
    protocol    = var.net_internal_allow_protocol_a
    }
  source_ranges = var.net_internal_source_ranges
}

resource "google_compute_firewall" "ssh-jumphost-firewall" {
  name          = "${var.prefix}-ssh-jumphost-firewall-rule"
  network       = google_compute_network.vpc_net.id
  description   = "Create Firewall rules for internal access from JumpHost"  
  allow {
    protocol    = var.net_jumphost_allow_protocol
    ports       = var.net_jumphost_allow_ports
  }  
  source_tags   = var.net_jumphost_tags
}


resource "google_compute_firewall" "health-check-firewall" {
  name          = "${var.prefix}-health-check-firewall-rule"
  network       = google_compute_network.vpc_net.id
  allow {
    protocol    = var.net_healthcheck_allow_protocol
    ports       = var.net_healthcheck_allow_ports
  }  
  source_ranges = var.net_healthcheck_source_ranges 
}

resource "google_compute_instance" "jumphost" {
  allow_stopping_for_update = true
  name         = "${var.prefix}-jump-host"
  machine_type = var.machine_type
  # region       = var.region
  project      = var.project
  zone         = var.zone
  metadata     = {
    ssh-keys   = var.ssh_key
  }
  boot_disk {
    initialize_params {
      image    = "${var.image_project}/${var.image_family}"
    }
  }
  network_interface {
    network    = var.vpc_net
    subnetwork = google_compute_subnetwork.vpc_subnet_public.id
    access_config {
    }
  }
  tags         = var.net_jumphost_tags
}

resource "google_compute_router" "vpc_net_router" {
  name         = "${var.prefix}-vpc-net-router"
  network      = var.vpc_net
  depends_on   = [google_compute_network.vpc_net]
}

resource "google_compute_router_nat" "vpc_net_nat" {
  name                               = "${var.prefix}-vpc-net-nat-router"
  router                             = google_compute_router.vpc_net_router.name
  region                             = google_compute_router.vpc_net_router.region
  nat_ip_allocate_option             = var.nat_auto_ip
  source_subnetwork_ip_ranges_to_nat = var.nat_all_ip_range
  depends_on   = [google_compute_network.vpc_net]
}
