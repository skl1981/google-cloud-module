resource "google_compute_disk" "default" {
  name = "terraform-disk"
  type = "pd-ssd"
  zone = "us-central1-c"
  size = 20
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.default.id
}
