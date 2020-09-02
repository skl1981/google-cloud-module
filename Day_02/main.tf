#do 
#export GOOGLE_CLOUD_KEYFILE_JSON=/path/to/file
#before apply
provider "google" {
  project = var.project
  region = var.region
}

resource "google_compute_instance" "nginx-terraform" {
    name = var.name
    zone = var.zone
    machine_type = var.machine_type
  boot_disk {
    initialize_params {
      image = var.image
      size = var.size
      type = var.disk_type
    }
  }
  tags = var.tags
  labels = var.labels
  metadata_startup_script = <<SCRIPT
       sudo yum update
       sudo yum install -y nginx
       sudo systemctl enable nginx
       sudo systemctl start nginx
    SCRIPT
  deletion_protection = var.del_prot
  network_interface {
    network = var.network
    access_config {
    }
  }
}