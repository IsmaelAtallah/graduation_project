variable "cluster_name" {}

variable "cluste_location" {}

variable "vpc_id" {}

variable "subnet_id" {}

variable "remove_default_node_pool" {
    type = bool
    default = true
}

variable "initial_node_count" {
  type = number
}

variable "enable_private_nodes" {
    type = bool
    default = false
}

variable "enable_private_endpoint" {
    type = bool
    default = false
}

variable "master_ipv4_cidr_block" {}

variable "cluster_ipv4_cidr_block" {}

variable "services_ipv4_cidr_block" {}

variable "master_authorized_cidr_block" {}

#############################
#      Node pool var        #
#############################

variable "node_pool_name" {}

variable "cluster_id" {}

variable "node_count" {
    type = number
}

variable "node_preemptible" {
  type= bool
  default = true 
}

variable "node_type" {}

variable "node_sa_email" {}

variable "node_oauth_scopes" {
  type = list(string) 
}