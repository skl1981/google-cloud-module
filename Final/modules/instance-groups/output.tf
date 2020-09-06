output "http_instance_group" {
    value = google_compute_region_instance_group_manager.nginx-web.instance_group
}
output "postgres_instance_group" {
    value = google_compute_region_instance_group_manager.postgres.instance_group
}