#--------------------------------------------------------------------------#
# Please be sure that you export variables that are necessary for working: #
# GOOGLE_CLOUD_KEYFILE_JSON, GOOGLE_APPLICATION_CREDENTIALS,               #
# GOOGLE_BACKEND_CREDENTIALS, etc.                                         #
#                                                                          #
# Current configuration is testing on Terraform v0.13.1                    #
#--------------------------------------------------------------------------#

terraform {
backend "gcs" {
bucket = "devops-lab-2020"
prefix = "terraform/state"
}
}
provider "google" {
  project     = "devops-lab-2020"
  region      = "us-central1"
}

