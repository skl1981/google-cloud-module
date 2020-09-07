output "web_group_name" {
  value = google_compute_region_instance_group_manager.web_external_group.name
}

output "db_group_name" {
  value = google_compute_region_instance_group_manager.db_internal_group.name
}