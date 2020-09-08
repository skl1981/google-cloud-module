provider "google" {
  project = "weighty-forest-288021"
  region  = var.region   
  credentials = "weighty-forest-288021-a66f9faea241.json"
}

###create VPC network

resource "google_compute_network" "vpc_network" {
  name                    = "${var.student_name}-vpc"
  auto_create_subnetworks = false
  description             = "vpc-network for task-3"
}

###create firewall rules

resource "google_compute_firewall" "external" {
  name    = "${var.student_name}-ext-firewall"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  description   = "rules for external connections"
}

resource "google_compute_firewall" "internal" {
  name    = "${var.student_name}-internall-firewall"
  network = google_compute_network.vpc_network.id
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = ["10.${var.student_id}.0.0/16"]  
  description   = "rules for internal connections"
}

###creating subnets

resource "google_compute_subnetwork" "public" {
  name          = "public-subnetwork"
  ip_cidr_range = "10.${var.student_id}.1.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "subnetwork-public ${var.student_name}"
 }

resource "google_compute_subnetwork" "private" {
  name          = "private-subnetwork"
  ip_cidr_range = "10.${var.student_id}.2.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "subnetwork-private ${var.student_name}"
 }

###creating instance

resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
    image = var.image
    size  = var.disk_size
    type  = var.disk_type
    }
  }

  metadata_startup_script = templatefile("./nginx.sh", {student_name = var.student_name})

  network_interface {
    network    = "${var.student_name}-vpc"
    subnetwork = google_compute_subnetwork.public.id
    access_config {
    }
  }
}
					 
