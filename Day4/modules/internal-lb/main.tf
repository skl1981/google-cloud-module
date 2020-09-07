resource "google_compute_health_check" "int_lb_hc" {
  name                  = var.mod_int_lb_hc_name 

  tcp_health_check {
    port = var.mod_int_lb_hc_port
  }
}

resource "google_compute_region_backend_service" "int_lb_bk" {
  name                  = var.mod_int_lb_bk_name 
  health_checks         = [google_compute_health_check.int_lb_hc.id]

  backend {
    group               = var.mod_int_backend_group
  } 
}

resource "google_compute_forwarding_rule" "int_lb_forw_rule" {
  name                  = var.mod_int_lb_forw_rule_name 
  load_balancing_scheme = var.mod_int_lb_forw_rule_scheme 
  backend_service       = google_compute_region_backend_service.int_lb_bk.id
  ports                 = var.mod_int_lb_forw_rule_ports 
  network               = var.mod_int_lb_forw_rule_network_name
  subnetwork            = var.mod_int_lb_forw_rule_subnetwork_name
}

