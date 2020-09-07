/*provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}*/

// =================create bastion instance=================

resource "google_compute_instance" "vm_instance" {
  name         = var.name_instance
  machine_type = var.machine_type
  description  = "${var.name_instance} for ssh conection"
  tags         = var.tags 
  boot_disk {
    initialize_params {
      image = var.image_jump
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }
  metadata = {
    ssh-keys = "${var.ssh_user_name}:${file(var.ssh_key_name)}"
  }
  network_interface {
    network       = var.net_name
    subnetwork    = var.sub_pub_name
    access_config {
    }
  }
}
