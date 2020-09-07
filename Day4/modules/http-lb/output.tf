output "http-lb-ip" {
  value = google_compute_global_forwarding_rule.http_lb_forw_rule.ip_address
}