resource "google_compute_health_check" "lb_health_check" {
  name = "exit-http-health-check"

  check_interval_sec = 1
  timeout_sec        = 1
  tcp_health_check {
    port = "${var.http-port}"
  }
}
resource "google_compute_backend_service" "exit_backend_site" {
  name          = "backend-service"
  health_checks = [google_compute_health_check.lb_health_check.id]
  #port_name   = "http"
  #protocol    = "HTTP"
  #load_balancing_scheme = "INTERNAL_SELF_MANAGED"
  backend {
    group = "${var.http-mig}"
  }
}
resource "google_compute_target_http_proxy" "exit_http_proxy" {
  #count = 1
  #project = var.project
  name    = "http-proxy"
  url_map = google_compute_url_map.default.id
}


resource "google_compute_url_map" "default" {
  name            = "url-map-target-proxy"
  description     = "a description"
  default_service = google_compute_backend_service.exit_backend_site.id
  #depends_on      = [google_compute_global_forwarding_rule.default, ]
  #  host_rule {
  #    hosts        = ["localhost"]
  #    path_matcher = "allpaths"
  #  }
  #
  #  path_matcher {
  #    name            = "allpaths"
  #    default_service = google_compute_backend_service.exit_backend_site.id

  #    path_rule {
  #      paths   = ["/*"]
  #      service = google_compute_backend_service.exit_backend_site.id
  #    }
  #  }
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "global-rule"
  target     = google_compute_target_http_proxy.exit_http_proxy.id
  port_range = "${var.http-port}"
  #load_balancing_scheme = "INTERNAL_SELF_MANAGED"
  #ip_address = "0.0.0.0"

}
