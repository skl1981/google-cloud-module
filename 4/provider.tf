provider "google" {
  credentials = file("terraform-admin.json")
  project     = var.project
  region      = var.region
}

/*terraform {
  backend "gcs" {
    bucket = "test-cloud-storage"
  }
}*/