resource "google_compute_instance" "nginx-server" {
name    =var.name
machine_type =var.machine_type
zone     =var.zone
tags     =var.tags
deletion_protection   =var.deletion
labels = var.labels  

boot_disk {
  initialize_params {
      image =var.image 
      size  =var.size
      type  =var.disk_type
    }
  }

network_interface {
    network = var.network

    access_config {
    }
  }
metadata_startup_script = var.script
}

output "External_IP" {
value = google_compute_instance.nginx-server.network_interface.0.access_config.0.nat_ip
}
