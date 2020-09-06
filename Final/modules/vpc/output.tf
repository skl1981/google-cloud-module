output "vpc_name" {
    value = google_compute_network.vpc.name
}
output "subnet_public" {
    value = google_compute_subnetwork.public_subnet.name
}
output "subnet_private" {
    value = google_compute_subnetwork.private_subnet.name
}
output "network_id" {
    value = google_compute_network.vpc.id
}
output "nat_ip" {
    value = google_compute_address.nat_ip.address
}