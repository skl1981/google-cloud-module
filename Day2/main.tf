provider "google" {
  credentials = file("terraform-admin.json")
  project     = "devopslab2020-288208"
  region      = "us-central1"
  zone 		  = "us-central1-c"
}

resource "google_compute_instance" "default" {
name                	= var.name
machine_type        	= var.machine_type
tags                	= var.tag
labels              	= var.labels
deletion_protection 	= var.delete
metadata_startup_script = file("nginx_server.sh")

boot_disk {
  initialize_params {
      image = var.image 
      size  = var.disk_size
      type  = var.disk_type
    }
  }

network_interface {
    network = var.network
    access_config {
    }
  }
}