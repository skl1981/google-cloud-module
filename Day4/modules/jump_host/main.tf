resource "google_compute_instance" "jump_host_create" {
  name         = var.mod_jump_host_name
  machine_type = var.mod_jump_host_type
  zone         = var.mod_jump_host_zone
  tags         = [var.mod_jump_host_tags]
  metadata = {
    ssh-keys = var.ssh_key
  }
  boot_disk {
    initialize_params {
      image    = var.mod_jump_host_image
    }
  }
    
  network_interface {
    network    = var.mod_jump_host_network_interface
    subnetwork = var.mod_jump_host_subnetwork
    access_config {
    }
  }
}