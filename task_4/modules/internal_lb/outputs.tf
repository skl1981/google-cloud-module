output "lb_ip" {
  value = google_compute_forwarding_rule.default.ip_address
}