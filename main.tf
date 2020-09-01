provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "turnkey-cyclist-287807"
  region      = "us-central1"
}

variable "name" {}

variable "zone" {}

variable "machine_type" {}

variable "disk_size" {
  type = number
}

variable "disk_type" {}

variable "image" {}

variable "tags" {
  type = list
}

variable "labels" {
  type = map
}

variable "delete" {
  type = bool
}

variable "script" {}

variable "network" {}

resource "google_compute_instance" "default" {
name                = var.name
zone                = var.zone
machine_type        = var.type
tags                = var.tags
labels              = var.labels
deletion_protection = var.delete

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
metadata_startup_script = var.script
}

output "URL" {
  value = "http://${google_compute_instance.nginx-gcp-terraform.network_interface.0.access_config.0.nat_ip}"
}