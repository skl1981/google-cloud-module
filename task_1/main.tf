# export GOOGLE_CLOUD_KEYFILE_JSON=~/servicekey/terraform.json
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
