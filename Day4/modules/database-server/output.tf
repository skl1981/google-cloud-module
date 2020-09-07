output "instance_group_db" {
    value = google_compute_region_instance_group_manager.db_mig.instance_group
}