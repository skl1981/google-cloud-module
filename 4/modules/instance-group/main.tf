/*provider "google" {
  credentials = file("terraform-admin.json")
  project     = var.project
  region      = var.region
}*/


#----------------------------
#     NGINX INSTANCE GROUP
#----------------------------
resource "google_compute_instance_template" "nginx_instance_template" {
  name_prefix  = var.nginx-instance-prefix
  machine_type = var.machine-type
  region       = var.region

  tags = var.ext-tags
  // boot disk
  disk {
    source_image = var.image
  }

  network_interface {
    subnetwork = var.sub-public-name
  }

  depends_on = [var.dependences]

  metadata_startup_script = templatefile("start_nginx.sh", {
    my_name = var.my_name
    my_surname = var.my_surname
  })

  metadata = {
    ssh-keys = "${var.ssh-user}:${var.ssh-keys}"
  }
}

resource "google_compute_region_instance_group_manager" "nginx-server" {
  name = var.group-manager-nginx-name
  region       = var.region
  distribution_policy_zones = var.multi-zones
  base_instance_name = var.base-instance-name-n
  target_size = 1

  version {
    instance_template  = google_compute_instance_template.nginx_instance_template.id
  }
}

#----------------------------
#     POSTGRES INSTANCE GROUP
#----------------------------
resource "google_compute_instance_template" "postgres_instance_template" {
  name_prefix  = var.postgres-instance-prefix
  machine_type = var.machine-type
  region       = var.region

  // boot disk
  disk {
    source_image = var.image
  }

  network_interface {
    subnetwork = var.sub-private-name
  }

  metadata = {
    ssh-keys = "${var.ssh-user}:${var.ssh-keys}"
  }
  metadata_startup_script = file("start_postgres.sh")

  depends_on = [var.dependences]
}

resource "google_compute_region_instance_group_manager" "postgres-server" {
  name = var.group-manager-postgres-name
  region       = var.region
  distribution_policy_zones = var.multi-zones
  base_instance_name = var.base-instance-name-p

  target_size = 3

  version {
    instance_template  = google_compute_instance_template.postgres_instance_template.id
  }
}

#--------------------------
#     AUTOSCALE
#--------------------------
resource "google_compute_region_autoscaler" "nginx-autoscaler" {
  name   = var.nginx-autoscaler-name
  region = var.region
  target = google_compute_region_instance_group_manager.nginx-server.id

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}