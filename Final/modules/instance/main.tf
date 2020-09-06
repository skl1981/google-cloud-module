#create jump-host
#create instance
resource "google_compute_instance" "jump-host" {
    name = var.name
    zone = var.zone
    machine_type = var.machine
    description = var.name
    tags = [var.name]
    can_ip_forward = var.bool
  boot_disk {
    initialize_params {
      image = var.image
      size = var.size
      type = var.disk_type
    }
  }

  metadata = var.meta_ssh_key

  metadata_startup_script = var.script
  network_interface {
    network = var.network
   subnetwork = var.subnet
    access_config {
        nat_ip = var.nat_ip
    }
  }
}
#create NAT
resource "google_compute_route" "nat-router" {
  depends_on = [google_compute_instance.jump-host]  
  name        = var.nat_name
  tags = var.tags
  dest_range  = var.range
  network     = var.network_id
  next_hop_instance = var.name
  next_hop_instance_zone = var.zone
  priority    = var.priority
}
