# create template for our servers

resource "google_compute_instance_template" "web_server" {
  name                 = "${var.student_name}-nginx-template"
  description          = "This template is used to create Nginx web server"
  instance_description = "Web Server running Nginx"
  can_ip_forward       = true
  machine_type         = var.machine_type
  metadata = {
	ssh-keys = var.ssh_key
  }
  tags = ["bastion", "nginx"]
  scheduling {
    automatic_restart = true
  }
  
  disk {
    source_image = var.images
    auto_delete  = true
    boot         = true
  }
  
  network_interface {
	network    = var.network_custom_vpc
    subnetwork = var.subnetwork_custom_public
  }
  
  lifecycle {
    create_before_destroy = true
  }

  metadata_startup_script = templatefile("web.sh.tpl", { 
    name    = "Dzmitry"  
    surname = "Kramich" })
}

resource "google_compute_instance_template" "db_server" {
  name                 = "${var.student_name}-db-template"
  description          = "This template is used to create db-postgres server"
  instance_description = "Db-postgress instance"
  can_ip_forward       = false
  machine_type         = var.machine_type
  metadata = {
    ssh-keys = var.ssh_key
  }
  
  tags = ["db-postgres"]
  scheduling {
    automatic_restart = true
  }
  disk {
    source_image = var.images
    auto_delete  = true
    boot         = true
  }
  
  network_interface {
	network    = var.network_custom_vpc
    subnetwork = var.subnetwork_custom_private
  }
  
  lifecycle {
    create_before_destroy = true
  }
  
  metadata_startup_script = file("db.sh")
}


# creates a group of virtual machine web-instances

resource "google_compute_region_instance_group_manager" "web_external_group" {
  name                      = "${var.student_name}-web-group"
  base_instance_name        = "${var.student_name}-web"
  region                    = var.region
  distribution_policy_zones = var.distribution_zones 
  version {
    instance_template = google_compute_instance_template.web_server.id
  }
  target_size  = var.web_replicas
}

# creates a group of virtual machine db-instances

resource "google_compute_region_instance_group_manager" "db_internal_group" {
  name                      = "${var.student_name}-db-group"
  base_instance_name        = "${var.student_name}-db"
  region                    = var.region
  distribution_policy_zones = var.distribution_zones 
  version {
    instance_template = google_compute_instance_template.db_server.id
  }
  target_size  = var.db_replicas
}
