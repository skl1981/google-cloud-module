output "ip_http_loadbalancer" {
  value = google_compute_global_forwarding_rule.nginx.ip_address
}
