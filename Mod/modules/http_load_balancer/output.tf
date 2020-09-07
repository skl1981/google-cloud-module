output "http_ip" {
  value = google_compute_global_forwarding_rule.http_lb_rule.ip_address
}
