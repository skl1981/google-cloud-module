#disk creation 
resource "google_compute_disk" "nginx-terraform" {
  name = "terraform-disk"
  type = "pd-standard"
  zone = "us-central1-c"
  size = 200
  physical_block_size_bytes = 4096
}
#attach disk
resource "google_compute_attached_disk" "nginx-terraform" {
  disk     = google_compute_disk.nginx-terraform.id
  instance = google_compute_instance.nginx-terraform.id
}
