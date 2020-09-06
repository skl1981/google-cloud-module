/*provider "google" {
  project = var.project_id
  region  = var.region
}*/


// =================create http load balancer======================

resource "google_compute_global_forwarding_rule" "default" {
  name                    = "global-rule"
  target                  = google_compute_target_http_proxy.default.id
  port_range              = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name                    = "target-proxy"
  url_map                 = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name                    = "url-map-target-proxy"
  default_service         = google_compute_backend_service.backend.id
}

data "google_compute_region_instance_group" "webserver" {
  name                    = "webserver-igm"
}

resource "google_compute_backend_service" "backend" {
  name                    = "backend"
  port_name               = "http"
  protocol                = "HTTP"
  timeout_sec             = 10
  
  backend {
    group                 = data.google_compute_region_instance_group.webserver.self_link
    balancing_mode        = "RATE"
    max_rate_per_instance = 50
  }
  health_checks = [google_compute_health_check.web.id]
}

resource "google_compute_health_check" "web" {
  name                   = "check-web"
  check_interval_sec     = 3
  timeout_sec            = 3
  http_health_check {
    request_path = "/"
    port         = "80"
  }
}