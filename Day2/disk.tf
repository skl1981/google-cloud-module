resource "google_compute_disk" "nginx-server" {
  name  = "mydisk1"
  type  = "pd-standard"
  zone  = "us-central1-c"
  size =200
}

resource "google_compute_attached_disk" "nginx-server" {
  disk     = google_compute_disk.nginx-server.id
  instance = google_compute_instance.nginx-server.id
}
