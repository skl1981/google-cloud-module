output "postgres_lb" {
    value = google_compute_forwarding_rule.postgres-forwarding-rule.ip_address
}