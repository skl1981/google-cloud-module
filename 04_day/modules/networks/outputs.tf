output "network-name" {
  value = google_compute_network.vpc_network.name
}

output "subnetwork-name-public" {
  value = google_compute_subnetwork.public.name
}

output "subnetwork-name-private" {
  value = google_compute_subnetwork.private.name
}