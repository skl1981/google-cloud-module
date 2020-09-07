resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = var.machine_type
  metadata = {
    ssh-keys = var.ssh_key
  }
  zone         = var.zone
  tags         = ["bastion"]

  boot_disk {
    initialize_params {
	  size  = var.disk_size
	  type  = var.disk_type
	  image = var.images
    }
  }
  network_interface {
	network = var.network_custom_vpc
    subnetwork = var.subnetwork_custom_public
	access_config {}
  }
}