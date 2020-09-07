resource "google_compute_http_health_check" "http_lb_hc" {
  name               = var.mod_http_lb_hc_name
}

resource "google_compute_backend_service" "http_lb_bk" {
  name               = var.mod_http_lb_bk_name 
  health_checks      = [google_compute_http_health_check.http_lb_hc.id]

  backend {
    group            = var.mod_backend_group
  }  
}

resource "google_compute_url_map" "http_lb_map" {
  name               = var.mod_http_lb_map_name 
  default_service    = google_compute_backend_service.http_lb_bk.id
}

resource "google_compute_target_http_proxy" "http_lb_proxy" {
  name               = var.mod_http_lb_proxy_name 
  url_map            = google_compute_url_map.http_lb_map.id
}

resource "google_compute_global_forwarding_rule" "http_lb_forw_rule" {
  name               = var.mod_http_lb_forw_rule_name 
  target             = google_compute_target_http_proxy.http_lb_proxy.id
  port_range         = var.mod_http_lb_forw_rule_port_range
}