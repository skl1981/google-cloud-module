output "bastion" {
  value = "ssh ubuntu@${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
}
