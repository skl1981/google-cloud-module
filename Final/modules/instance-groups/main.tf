#create nginx-web instance group
resource "google_compute_region_autoscaler" "nginx" {
  name   = var.autoscaler_name
  target = google_compute_region_instance_group_manager.nginx-web.id
  region = var.region

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = var.cooldown_period
    
    cpu_utilization {
      target = var.cpu_target
    }
  }
}

resource "google_compute_region_instance_group_manager" "nginx-web" {
  name = var.nginx_igm_name
  base_instance_name         = var.nginx_igm_base_name
  region                     = var.region
  distribution_policy_zones  = var.nginx_igm_zones

  version {
    instance_template = var.nginx_igm_template
  }
  named_port {
    name = var.nginx_igm_named_port_name
    port = var.nginx_igm_named_port_port
  }
}
#create postgress instance group
resource "google_compute_region_instance_group_manager" "postgres" {
  name = var.postgres_igm_name
  base_instance_name         = var.postgres_igm_base_name
  region                     = var.region
  distribution_policy_zones  = var.postgres_igm_zones
  version {
    instance_template = var.postgres_igm_template
  }
  target_size  = var.postgres_igm_target_size
  named_port {
    name = var.postgres_igm_named_port_name
    port = var.postgres_igm_named_port_port
  }
}
