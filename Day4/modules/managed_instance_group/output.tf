output "managed_group_name" {
  value = google_compute_region_instance_group_manager.mig.name
}
output "managed_group_self_link" {
  value = google_compute_region_instance_group_manager.mig.self_link
}
output "managed_group_id" {
  value = google_compute_region_instance_group_manager.mig.id
}
output "managed_group_instance_group" {
  value = google_compute_region_instance_group_manager.mig.instance_group
}
