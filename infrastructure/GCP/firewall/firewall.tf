resource "google_compute_firewall" "iap-ssh" {
  network   = var.vpc_name
  name      = var.firewall_name
  priority  = var.priority
  direction = var.direction
  allow {
    protocol = var.protocol
    ports    = var.ports
  }
  source_ranges = var.source_ranges
}
