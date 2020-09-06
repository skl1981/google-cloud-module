output "nginx_template_id" {
    value = google_compute_instance_template.nginx.id
}
output "postgres_template_id" {
    value = google_compute_instance_template.postgres.id
}