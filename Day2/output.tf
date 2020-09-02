output "External_ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}

output "Network_name" {
  value = "${google_compute_network.vpc_network.name}"
}

output "Public_Network_CIDR" {
  value = "${google_compute_subnetwork.public.ip_cidr_range}"
}

output "Private_Network_CIDR" {
  value = "${google_compute_subnetwork.private.ip_cidr_range}"
}

output "VM_instance_name" {
  value = "${google_compute_instance.default.name}"
}

output "Zone" {
  value = "${google_compute_instance.default.zone}"
}

output "Machine_type" {
  value = "${google_compute_instance.default.machine_type}"
}
