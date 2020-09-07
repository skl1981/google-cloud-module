
// bastion 

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
  
  network_interface {
    network       = var.net_name
    subnetwork    = var.sub_pub_name
    access_config {
    }
  }
  
  metadata = {
    ssh-keys = "ubuntu:${file("key.pub")}"
  }
}
