resource "google_container_cluster" "cluster" {
  name     = "${var.cluster_name}"
  location = "${var.cluste_location}"
  network =  var.vpc_id 
  subnetwork = var.subnet_id 
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count

  private_cluster_config {
    enable_private_nodes=var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block = "${var.master_ipv4_cidr_block}"

  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block =  "${var.cluster_ipv4_cidr_block}"
    services_ipv4_cidr_block = "${var.services_ipv4_cidr_block}"

  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block ="${var.master_authorized_cidr_block}"
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.node_pool_name}"
  cluster    = var.cluster_id
  node_count = var.node_count
  
  node_config {
    preemptible  = var.node_preemptible
    machine_type = "${var.node_type}"

    service_account = var.node_sa_email
    oauth_scopes = var.node_oauth_scopes
  }
  
}

