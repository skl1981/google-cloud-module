provider "google" {
  credentials = "terraform-admin.json"
  project     = var.project
  region      = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.student_name}-vpc"
  auto_create_subnetworks = false
  description             = "custom-vpc-network"
}

resource "google_compute_firewall" "external" {
  name    = "${var.student_name}-firewall-external"
  network = google_compute_network.vpc_network.name
  allow {
    ports    = var.external_ports
	protocol = "tcp"
  }
  source_ranges = var.external_ranges
  description   = "rule for http and ssh for external conections"
}

resource "google_compute_firewall" "internal" {
  name    = "${var.student_name}-firewall-internal"
  network = google_compute_network.vpc_network.name
  allow {
    ports    = var.internal_ports
    protocol = "tcp"
  }
  allow {
    ports    = var.internal_ports
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = var.internal_ranges
  description   = "rule for internal conections ${var.student_name}-vpc"
}

resource "google_compute_subnetwork" "public" {
  name          = "public-subnet"
  ip_cidr_range = var.public_subnet
  network       = google_compute_network.vpc_network.id
  description   = "public-subnet in ${var.student_name}-vpc"
}

resource "google_compute_subnetwork" "private" {
  name          = "private-subnet"
  ip_cidr_range = var.private_subnet
  network       = google_compute_network.vpc_network.id
  description   = "private-subnet in ${var.student_name}-vpc"
  private_ip_google_access = true
}

resource "google_compute_instance" "nginx-terraform" {
  name         = "nginx-terraform-task3"
  machine_type = var.machine_type
  zone         = var.zone
  description  = "nginx-web"

  boot_disk {
    initialize_params {
      size  = var.disk_size
      type  = var.disk_type
	  image = "centos-7"
    }
  }
  metadata_startup_script = templatefile("install.sh.tpl", { my_name = "${var.student_name}" })
  
  network_interface {
	network = "${var.student_name}-vpc"
    subnetwork = google_compute_subnetwork.public.id
	access_config {}
  }
}