terraform {
  backend "gcs" {
    bucket = " "
    prefix = "terraform/terraform.tfstate"
  }
}