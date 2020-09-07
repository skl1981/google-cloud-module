/*provider "google" {
  project = var.project_id
  region  = var.region
}*/


// =================create http load balancer======================

resource "google_compute_global_forwarding_rule" "default" {
  name                    = "${var.name}-rule"
  target                  = google_compute_target_http_proxy.default.id
  port_range              = var.lb_proxy_port 
}

resource "google_compute_target_http_proxy" "default" {
  name                    = "${var.name}-target-proxy"
  url_map                 = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name                    = var.name
  default_service         = google_compute_backend_service.backend.id
}


resource "google_compute_backend_service" "backend" {
  name                    = "${var.name}-backend-service"
  port_name               = var.lb_proxy_port_name
  protocol                = var.lb_protocol 
  timeout_sec             = 10
  
  backend {
    group                 = data.google_compute_region_instance_group.webserver.self_link
    balancing_mode        = "RATE"
    max_rate_per_instance = 50
  }
  health_checks = [google_compute_health_check.web.id]
}

data "google_compute_region_instance_group" "webserver" {
  name                    =  var.ins_group_name  
}

resource "google_compute_health_check" "web" {
  name                    = "${var.name}-health-check"
  check_interval_sec      = 3
  timeout_sec             = 3
  http_health_check {
    request_path = "/"
    port         = var.lb_hc_port
  }
}