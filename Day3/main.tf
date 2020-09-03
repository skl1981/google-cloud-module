provider "google" {
  credentials = file("terraform-admin.json")
  project     = "devopslab2020-288208"
  region      = "us-central1"
}

resource "google_compute_network" "default" {
name 					= "${var.student_name}-vpc"
auto_create_subnetworks = false
description				= "Create VPC network"
}

resource "google_compute_firewall" "external" {
name   					= var.exfwname
network 				= google_compute_network.default.name
description				= "Create external firewall ruls"
source_ranges		    = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
}

resource "google_compute_firewall" "internal" {
name   					= var.infwname
network 				= google_compute_network.default.name
description				= "Create internal firewall ruls"
source_ranges		    = ["10.${var.student_IDnum}.0.0/16"]

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  
    allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
}

resource "google_compute_subnetwork" "public" {
name          			= var.netpubname
ip_cidr_range			= "10.${var.student_IDnum}.1.0/24"
network     			= google_compute_network.default.id
description 			= "Create public subnetwork"
}

resource "google_compute_subnetwork" "private" {
name          			= var.netprivname
ip_cidr_range			= "10.${var.student_IDnum}.2.0/24"
network     			= google_compute_network.default.id
description 			= "Create private subnetwork"
}

resource "google_compute_instance" "default" {
name                	= "nginx-${var.student_name}"
zone         			= var.zone
machine_type        	= var.machine_type
metadata_startup_script = templatefile("nginx_server.sh", {student_name = "${var.student_name}"})
description				= "Create VM instance"

boot_disk {
  initialize_params {
      image = var.image 
      size  = var.disk_size
      type  = var.disk_type
    }
  }

network_interface {
	network    = google_compute_network.default.id
    subnetwork = google_compute_subnetwork.public.id
    access_config {
    }
  }
}