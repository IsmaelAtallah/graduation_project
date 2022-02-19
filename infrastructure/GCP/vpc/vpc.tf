resource "google_compute_network" "vpc_network" {
  #project                 = "my-project-name"
  name                    = var.vpc_name
  auto_create_subnetworks = var.creat_subnets
}