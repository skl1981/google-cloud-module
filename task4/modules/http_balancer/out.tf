output "lb-ip" {
  value = "http://${google_compute_global_forwarding_rule.default.ip_address}"
}
         
