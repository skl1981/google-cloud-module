provider "google" {
  credentials = file("/home/mumz/.servicekey/terraform-admin.json")
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "nginx" {
name = var.name
zone = var.zone
labels = var.label
machine_type = var.machine_type

boot_disk {
  initialize_params {
    type = var.boot_disk_type
    image = "${var.image_project}/${var.image_family}"
    size = var.boot_disk_size
  }
  }

deletion_protection = var.deletion_protection
tags = var.tag

network_interface {
    network = var.network
    access_config {
    }
  }

 metadata_startup_script = var.script

service_account {
  email = var.service_account_email
  scopes = var.service_account_scope
}
}
