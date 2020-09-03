resource "google_compute_disk" "nginx" {
  name  = "disk-attached"
  type  = "pd-ssd"
  zone  = "us-central1-c"
  labels = {
    environment = "dev"
  }
  size  = 30
}

resource "google_compute_attached_disk" "nginx" {
  disk     = google_compute_disk.nginx.id
  instance = google_compute_instance.nginx.id
}
