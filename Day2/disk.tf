resource "google_compute_disk" "default" {
  name  = "terraform-disk"
  type  = "pd-standard"
  size  = 200
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.default.id
}
