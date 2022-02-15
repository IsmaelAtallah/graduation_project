#terraform {
#  backend "gcs" {
#    credentials = "${file("som3a-iti-d3962c5c0abc.json")}"
#    bucket  = "grad-project-tf"
#    prefix  = "terraform/terraform.tfstate"
#  }
#}