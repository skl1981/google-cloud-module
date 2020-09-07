######-----create jump-host
resource "google_compute_instance" "jump_host" {
  name         = "jump-host-${var.createway}"
  machine_type = "${var.machinetype}"
  zone         = "${var.zone}"
  #  deletion_protection = var.delprot
  # metadata_startup_script = file("starup.sh")
  description = "create jamp-host to ssh"
  tags        = ["jamphost"]
  metadata = {
    ssh-keys = "aliaksandr_mazurenka:${file("dopkey.pub")} \ncmetaha17:${file("id_rsa.pub")}"
  }
  #    tags = var.tags
  #    labels = var.labels
  metadata_startup_script = <<EFO

EFO

  #  depends_on = [google_compute_network.vpc_network, ]

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size  = "${var.hdd-size}"
      type  = "${var.hdd-type}"
    }
  }
  network_interface {
    #  count      = "${var.network-name}" == "default" ? 0 : 1
    network    = "${var.network-name}"         #google_compute_network.vpc_network.id
    subnetwork = "${var.sub-network-ext-name}" #google_compute_subnetwork.public_sub_net.id
    access_config {
      // Ephemeral IP
    }
  }
}
