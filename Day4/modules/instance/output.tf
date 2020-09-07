output "bastion_external_ip" {
  value = google_compute_instance_from_template.compute_instance_public.network_interface.0.access_config.0.nat_ip 
}

