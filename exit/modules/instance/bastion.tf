/////////////////
///jump-server///
/////////////////

resource "google_compute_instance" "bastion" {
  name = var.name_instance
  machine_type = var.machine_type
  description  = "jump host for ssh conection"
  tags = ["ssh-jump"]
  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
      size = var.disk_size_gb
      type = var.disk_type
    }
  }
  metadata = {
    ssh-keys = "centos7:${file("key.pub")}"
  }
  network_interface {
    network = var.net_name
    subnetwork = var.public_sub_name
    access_config {}
  }
}