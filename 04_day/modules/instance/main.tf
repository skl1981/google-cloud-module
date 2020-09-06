/*provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}*/

// =================create bastion instance=================

resource "google_compute_instance" "vm_instance" {
  name         = var.name_instance
  machine_type = var.machine_type
  description  = "jump host for ssh conection"
  tags         = ["ssh-jump"]
  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file("key.pub")}"
  }
  network_interface {
    network       = var.net_name
    subnetwork    = var.sub_pub_name
    access_config {
    }
  }
}
