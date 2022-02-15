resource "google_compute_subnetwork" "subnets" {
  count = length(var.subnet_cider_block)
  name          = "${var.name}-${count.index}"
  ip_cidr_range = "${var.subnet_cider_block[count.index]}"
  region        = "${var.region}"
  network       = "${var.vpc_id}"
}