resource "google_compute_disk" "nginx-terraform" {
  name  = "test-terraform"
  type  = "pd-ssd"
  zone  = "us-central1-c"
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "nginx-terraform" {
  disk     = google_compute_disk.nginx-terraform.id
  instance = google_compute_instance.default.id
}



