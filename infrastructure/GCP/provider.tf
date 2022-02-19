provider "google" {
  credentials = file("${var.credentials}")
  project     = var.project_name
  region      = var.regions
}