output "internal-balancer-ip-address" {
  value = google_compute_forwarding_rule.internal-lb.ip_address
}
