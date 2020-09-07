output "subnetwork_range" {
  value       = google_compute_subnetwork.vpc_subnetwork.ip_cidr_range
  description = "The created subnet resources"
}
output "subnetwork_name" {
  value       = google_compute_subnetwork.vpc_subnetwork.name
  description = "The created subnet resources"
}
