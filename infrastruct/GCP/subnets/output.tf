output "subnet_id" {
  value = google_compute_subnetwork.subnets[*].id
}

output "subnet_name" {
  value = google_compute_subnetwork.subnets[*].name
}

output "region" {
  value = google_compute_subnetwork.subnets[*].region
}

