variable "nat_name" {}

variable "region" {}

variable "router_id" {}

variable "ip_allocate" {}

variable "source_subnetwork_ip_ranges" {}

variable "subnets_name" {}

variable "ip_range" {
  type = list(string)
}