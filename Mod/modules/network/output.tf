output "subnet_public_name" {
  value = google_compute_subnetwork.public.name
}

output "subnet_private_name" {
  value = google_compute_subnetwork.private.name
}

output "network_name" {
  value = google_compute_network.vpc_network.name
}
