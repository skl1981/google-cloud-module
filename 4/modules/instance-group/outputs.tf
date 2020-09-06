output "instance-group" {
  value = google_compute_region_instance_group_manager.nginx-server.instance_group
}

output "instance-group-postgres" {
  value = google_compute_region_instance_group_manager.postgres-server.instance_group
}