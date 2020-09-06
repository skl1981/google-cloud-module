terraform {
  backend "gcs" {
    bucket      = "aafanasenko-bucket"
    prefix      = "backend/terraform.tfstate"
  }
}
