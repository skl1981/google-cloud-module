resource "google_compute_instance_template" "instance_template" {
  name_prefix = "${var.name_prefix}-"
  machine_type = var.machine_type
  metadata = var.metadata
  region = var.region
  tags = var.tags
  metadata_startup_script = var.script
  disk {
     source_image = var.image
     disk_size_gb = var.disk_size_gb
     disk_type = var.disk_type
  }
  network_interface{
    subnetwork = var.subnetwork_name
  }
}

resource "google_compute_region_instance_group_manager" "mig" {
  name = var.group_name
  base_instance_name = var.base_instance_name
  region = var.region
  distribution_policy_zones = var.distribution_policy_zones
  version {
    instance_template = google_compute_instance_template.instance_template.id
  }
  target_size = var.target_size
  dynamic "named_port" {
    for_each = var.named_ports
    content {
      name = lookup(named_port.value, "name", null)
      port = lookup(named_port.value, "port", null)
    } 
  }
}
resource "google_compute_region_autoscaler" "default" {
  count = var.autoscaler? 1 : 0
  region = var.region
  name   = "my-autoscaler"
  target = google_compute_region_instance_group_manager.mig.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 60
    
    cpu_utilization {
      target = 0.5
    }

  }
}
