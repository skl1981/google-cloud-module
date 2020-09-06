#create web instance template
resource "google_compute_instance_template" "nginx" {
    name = var.nginx_name
    region = var.region
    machine_type = var.nginx_machine
    description = "centos with installed nginx and postgres client template"
    tags = [var.nginx_name]

    disk  {
      source_image = var.nginx_image
      auto_delete = var.bool
      boot = var.bool
      disk_size_gb = var.nginx_disk_size
      disk_type = var.nginx_disk_type
    }
      metadata = var.meta_ssh_key
    metadata_startup_script = var.nginx_script
    network_interface {
    network = var.network
    subnetwork = var.nginx_subnet
    }
}

#create postgres instance template
resource "google_compute_instance_template" "postgres" {
    name = var.postgres_name
    region = var.region
    machine_type = var.postgres_machine
    description = "centos with installed nginx template"
    tags = [var.postgres_name]

    disk  {
      source_image = var.postgres_image
      auto_delete = var.bool
      boot = var.bool
      disk_size_gb = var.postgres_disk_size
      disk_type = var.postgres_disk_type
    }
    metadata = var.meta_ssh_key
    metadata_startup_script = var.postgres_script
    network_interface {
    network = var.network
    subnetwork = var.postgres_subnet
  }
}
