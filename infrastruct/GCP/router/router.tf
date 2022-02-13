resource "google_compute_router" "router" {
  name    = "${var.router_name}"
  network = "${var.vpc_id}"
}