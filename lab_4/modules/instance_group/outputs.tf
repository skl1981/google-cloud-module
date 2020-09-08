output "web_instance_group_name" {
  value = google_compute_region_instance_group_manager.manager_web_server.name
}
output "db_instance_group_name" {
  value = google_compute_region_instance_group_manager.dbserver.name
}