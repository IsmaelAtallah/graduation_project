terraform {
  backend "gcs" {
    bucket  = "grad-project-tf"
    prefix  = "terraform/state"
  }
}