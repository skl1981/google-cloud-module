data "google_compute_region_instance_group" "web_server" {
  name                    = var.instancegroup_name
}

resource "google_compute_global_forwarding_rule" "default" {
  name                    = "${var.prefix}-global-forwarding-rule"
  target                  = google_compute_target_http_proxy.default.id
  port_range              = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name                    = "${var.prefix}-target-http-proxy"
  url_map                 = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name                    = "${var.prefix}-url-map"
  default_service         = google_compute_backend_service.default.id
}

resource "google_compute_backend_service" "default" {
  name                    = "${var.prefix}-backend-service"
  port_name               = var.backend_service_port_name
  protocol                = var.backend_service_protocol
  timeout_sec             = var.backend_service_timeout_sec
  health_checks           = [google_compute_health_check.web.id]
  backend {
    group                 = data.google_compute_region_instance_group.web_server.id
    balancing_mode        = var.backend_service_balancing_mode
    max_rate_per_instance = var.backend_service_max_rate_per_instance
  }
  depends_on              = [google_compute_health_check.web]
}

resource "google_compute_health_check" "web" {
  name                    = "${var.prefix}-web-health-check"
  timeout_sec             = var.healthckeck_timeout_sec
  check_interval_sec      = var.healthckeck_check_interval_sec
  healthy_threshold       = var.healthckeck_healthy_threshold
  unhealthy_threshold     = var.healthckeck_unhealthy_threshold
  http_health_check {
    port                  = var.healthckeck_loadbalancer_port
  }
}