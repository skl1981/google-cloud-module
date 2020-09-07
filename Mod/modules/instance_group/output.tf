output "db_instance_group" {
  value = google_compute_region_instance_group_manager.db.instance_group
}
output "instance_group_web" {
  value = google_compute_region_instance_group_manager.web_server.instance_group
}
