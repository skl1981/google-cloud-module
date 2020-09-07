#####################################################################
# Creating backend service + http_health_check

resource "google_compute_http_health_check" "http_health_check" {
  name               = "web-http-health-check"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_backend_service" "web" {
  name          = "web-backend-service"
  health_checks = [google_compute_http_health_check.http_health_check.id]

  backend {
    group = var.instance_group_web
  }
}


#####################################################################
# Creating url_map

resource "google_compute_url_map" "web_server" {
  name            = "web-server-map-target-proxy"
  default_service = google_compute_backend_service.web.id
  description     = "for http load balancer"

  host_rule {
    hosts        = ["*"]
    path_matcher = "path"
  }

  path_matcher {
    name            = "path"
    default_service = google_compute_backend_service.web.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.web.id
    }
  }
}


#####################################################################
# Creating target http proxy

resource "google_compute_target_http_proxy" "proxy" {
  name        = "web-server-target-proxy"
  description = "for http load balancer"
  url_map     = google_compute_url_map.web_server.id
}


#####################################################################
# Creating forwarding rule

resource "google_compute_global_forwarding_rule" "http_lb_rule" {
  name       = "http-lb-rule"
  target     = google_compute_target_http_proxy.proxy.id
  port_range = "80"
}
