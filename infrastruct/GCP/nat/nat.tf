resource "google_compute_router_nat" "nat" {
  name                               = "${var.nat_name}"
  router                             = "${var.router_name}"
  nat_ip_allocate_option             = "${var.ip_allocate}"
  source_subnetwork_ip_ranges_to_nat = "${var.source_subnetwork_ip_ranges}"
  subnetwork {
    name                    = "${var.subnets_name}"
    source_ip_ranges_to_nat = ["${var.ip_range}"]
  }
}
