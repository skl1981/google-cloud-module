# ===========================Create VPC========================================
resource "google_compute_network" "default" {
  name                    = var.network
  auto_create_subnetworks = false
}

# =======================Create public subnet==================================
resource "google_compute_subnetwork" "public_subnet" {
  name          = var.public_subnet_name
  region        = var.region
  ip_cidr_range = var.public_subnet_cidr
  network       = google_compute_network.default.name
}

# =======================Create private subnet==================================
resource "google_compute_subnetwork" "private_subnet" {
  name          = var.private_subnet_name
  region        = var.region
  ip_cidr_range = var.private_subnet_cidr
  network       = google_compute_network.default.name
}

# ========Create firewall rule for external access (to  all or bastion)==========
resource "google_compute_firewall" "allow_external" {
  name    = "${var.name}-allow-external"
  network = google_compute_network.default.id
  allow {
    protocol = "tcp"
    ports    = lookup(var.allow_external, "allow_ports")
  }
  source_ranges = lookup(var.allow_external, "source_ranges")
  target_tags   = var.create_bastion ? var.bastion_tags : []
  description   = "Firewall rule for external access to bastion host"
}

# ====================Create firewall rule for internal access==================
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.name}-allow-internal"
  network = google_compute_network.default.id
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = lookup(var.allow_internal, "allow_ports")
  }
  allow {
    protocol = "udp"
    ports    = lookup(var.allow_internal, "allow_ports")
  }
  source_ranges = lookup(var.allow_internal, "source_ranges")
  description   = "Firewall rule for internal accress"
}

# ================Create firewall rule for ssh access from bastion==============
resource "google_compute_firewall" "allow-ssh-internal" {
  count   = var.create_bastion ? 1 : 0
  name    = "${var.name}-allow-ssh-internal"
  network = google_compute_network.default.id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_tags = var.bastion_tags
  description = "Firewall rule for internal accress from bastion host"
}

# ================Create firewall rule for allow http_health_check==============

resource "google_compute_firewall" "allow-health-check" {
  count   = var.allow_health_check ? 1 : 0
  name    = "allow-health-check"
  network = google_compute_network.default.id
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}

#======================Create bastion host ============================
resource "google_compute_instance" "bastion" {
  count        = var.create_bastion ? 1 : 0
  name         = "${var.name}-bastion-host"
  machine_type = var.machine_type
  zone         = var.zone
  metadata = {
    ssh-keys = var.ssh_key
  }
  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
    }
  }
  network_interface {
    network    = var.network
    subnetwork = google_compute_subnetwork.public_subnet.id
    access_config {
    }
  }
  tags = var.bastion_tags
}
