output "db-group-instance" {
  value = google_compute_region_instance_group_manager.dbserver.name
}

output "web-group-instance" {
  value = google_compute_region_instance_group_manager.webserver.name
}
