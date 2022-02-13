provider "google" {
  credentials = "${file("som3a-iti-d3962c5c0abc.json")}"
  project     = "som3a-iti"
  region      = "europe-north1-a"
}