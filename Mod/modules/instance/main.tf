##################################################################
# Jump-server

resource "google_compute_instance" "default1" {
  name                      = var.name1
  machine_type              = var.machine_type
  zone                      = var.zone1
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }

  network_interface {
    network    = "${var.student_name}-vpc"
    subnetwork = var.subnet_public_name
    access_config {
      // Ephemeral IP
    }
  }
  tags = ["jump"]
  metadata = {
    ssh-keys = "aliaksandr_mazurenka:${file("id_rsa.pub")}"
  }
  metadata_startup_script = <<SCRIPT
    sudo yum update
    sudo yum install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "<h1>Hello from ${var.student_name}</h1>" > /usr/share/nginx/html/index.html
SCRIPT
}
