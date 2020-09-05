data "google_compute_zones" "list" {
  region = var.region
}

# ================Create template instance for MIG==============================
resource "google_compute_instance_template" "default" {
  name_prefix  = "${var.name}-template-"
  description  = "This template is used to create ${var.name}-instances"
  machine_type = var.machine_type
  metadata = {
    ssh-keys = var.ssh_key
  }
  metadata_startup_script = var.startup_script == "" ? templatefile("${path.module}/nc.sh", {
    nc_port = var.ig_health_check_port
    }) : templatefile(var.startup_script, {
    studentName    = "Ilya"
    studentSurname = "Melnik"
  })
  disk {
    source_image = "${var.image_project}/${var.image_family}"
  }
  network_interface {
    network    = var.subnetwork == "" ? var.network : ""
    subnetwork = var.subnetwork
    dynamic "access_config" {
      for_each = var.ext_ip ? [""] : []
      content {
        nat_ip = access_config.value
      }
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

## ====Create regional MIG with health_check and update policy for blue/green==
resource "google_compute_region_instance_group_manager" "default" {
  name                      = "${var.name}-instance-group"
  base_instance_name        = "${var.name}-instance"
  region                    = var.region
  distribution_policy_zones = var.distribution_zones
  target_size               = var.instance_count

  update_policy {
    type            = "PROACTIVE"
    minimal_action  = "REPLACE"
    max_surge_fixed = length(data.google_compute_zones.list)
  }
  auto_healing_policies {
    health_check      = element(compact(concat(google_compute_health_check.tcp.*.id, google_compute_health_check.http.*.id)), 0)
    initial_delay_sec = 300
  }
  version {
    instance_template = google_compute_instance_template.default.id
  }
}

# ========================Create health_check==================================
resource "google_compute_health_check" "tcp" {
  count               = var.http_health_check ? 0 : 1
  name                = "${var.name}-ig-health-check"
  timeout_sec         = var.hc_timeout_sec
  check_interval_sec  = var.hc_check_interval_sec
  healthy_threshold   = var.hc_healthy_threshold
  unhealthy_threshold = var.hc_unhealthy_threshold
  tcp_health_check {
    port = var.ig_health_check_port
  }
}
resource "google_compute_health_check" "http" {
  count               = var.http_health_check ? 1 : 0
  name                = "${var.name}-ig-health-check"
  timeout_sec         = var.hc_timeout_sec
  check_interval_sec  = var.hc_check_interval_sec
  healthy_threshold   = var.hc_healthy_threshold
  unhealthy_threshold = var.hc_unhealthy_threshold
  http_health_check {
    port = var.ig_health_check_port
  }
}

# Firewall for health check
resource "google_compute_firewall" "default" {
  count   = var.firewall_rule_hc ? 1 : 0
  name    = "${var.name}-fw-ig-hc"
  network = var.network
  allow {
    protocol = "tcp"
    ports    = [var.ig_health_check_port]
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}

