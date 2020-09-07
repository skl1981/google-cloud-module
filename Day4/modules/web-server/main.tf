resource "google_compute_instance_template" "nginx_template" {
  name_prefix               = var.mod_nginx_template_prefix 
  machine_type              = var.mod_nginx_template_type
  tags                      = [var.mod_nginx_template_tags]
  metadata_startup_script   = templatefile("./modules/web-server/nginx_server.sh", {studentName = var.mod_studentName, studentSurname = var.mod_studentSurname})
  metadata = {
	ssh-keys = var.ssh_key
  }
  
  disk {
    source_image            = var.mod_nginx_template_image
  }

  network_interface {
    network                 = var.mod_nginx_template_network_interface
    subnetwork              = var.mod_nginx_template_subnetwork
  }
}

resource "google_compute_region_instance_group_manager" "nginx_mig" {
  name                      = var.mod_nginx_mig_name
  base_instance_name        = var.mod_nginx_mig_base_name
  distribution_policy_zones = [var.mod_nginx_mig_zone_a, var.mod_nginx_mig_zone_b, var.mod_nginx_mig_zone_c]
  region                    = var.mod_nginx_mig_region
  target_size               = var.mod_nginx_mig_target_size

    version {
    instance_template       = google_compute_instance_template.nginx_template.id
  }
}

resource "google_compute_region_autoscaler" "nginx_scaler" {
  name                      = var.mod_nginx_scaler_name
  target                    = google_compute_region_instance_group_manager.nginx_mig.id

  autoscaling_policy {
    min_replicas            = var.mod_nginx_scaler_min_rep
    max_replicas            = var.mod_nginx_scaler_max_rep
    cooldown_period         = var.mod_nginx_scaler_cool_per

    cpu_utilization {
      target                = var.mod_nginx_scaler_target
    }
  }
}