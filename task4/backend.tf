# bucket

terraform {

  backend "gcs" {

    bucket = "sakhonchik"

    prefix = "terraform_data/"

  }

}
