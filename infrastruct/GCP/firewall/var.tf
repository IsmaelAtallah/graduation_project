variable "vpc_name" {}

variable "firewall_name" {}

variable "priority" {
  type = number
}

variable "direction" {}

variable "protocol"{}

variable "ports" {
  type = list(string)
}

variable "source_ranges" {
  type = list(string)
}