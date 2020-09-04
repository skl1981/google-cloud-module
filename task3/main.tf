provider "google" {
  project = "vladimir-project-01"
  region  = "us-central1"
  credentials = file("vladimir-project-01-c4a426ae902c.json") 
}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.student_name}-vpc"
  description             = "${var.student_name}-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "external_access" {
  name    = "${var.student_name}-ext-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}

resource "google_compute_firewall" "internal_access" {
  name    = "${var.student_name}-int-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.${var.student_id}.2.0/24"]
}

resource "google_compute_subnetwork" "public" {
  name          = "public-subnetwork"
  ip_cidr_range = "10.${var.student_id}.1.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "${var.student_name}-public subnetwork"
}

resource "google_compute_subnetwork" "private" {
  name          = "private-subnetwork"
  ip_cidr_range = "10.${var.student_id}.2.0/24"
  network       = google_compute_network.vpc_network.id
  description   = "${var.student_name}-private subnetwork"
}

variable "instance_allow_stopping_for_upd" {
  type  = bool
}

variable student_name {}
variable student_id {
  type = number
}
variable "name" {}
variable "machine_type" {}
variable "zone" {}
variable "image" {}
variable "type" {}
variable "size" {
  type = number
}
variable "network" {}


resource "google_compute_instance" "default" {
  name                = var.name
  machine_type        = var.machine_type
  zone                = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }

  network_interface {
    network = var.network
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = file("install.nginx")    
  


}
