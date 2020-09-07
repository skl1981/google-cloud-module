output "http-backend-name" {
  value = google_compute_region_instance_group_manager.appserver.name
}
output "internal-backend-name" {
  value = google_compute_region_instance_group_manager.dbserver.name
}
output "http-mig" {
  value = google_compute_region_instance_group_manager.appserver.instance_group
}
output "internal-mig" {
  value = google_compute_region_instance_group_manager.dbserver.instance_group
}
