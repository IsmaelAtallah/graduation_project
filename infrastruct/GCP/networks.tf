# creat vpc
module "grad_vpc" {
  source        = "./vpc"
  vpc_name      = "grad-project-vpc"
  creat_subnets = false
}

# creat subnets
module "public_subnets" {
  source             = "./subnets"
  name               = "public"
  subnet_cider_block = ["10.0.1.0/24"]
  region             = "europe-north1"
  vpc_id             = module.grad_vpc.vpc_id
}

module "private_subnets" {
  source             = "./subnets"
  name               = "private"
  subnet_cider_block = ["10.0.2.0/24"]
  region             = "europe-north1"
  vpc_id             = module.grad_vpc.vpc_id
}

#creat router

module "nat_router" {
  source      = "./router"
  router_name = "nat-router"
  region      = module.public_subnets.region[0]
  vpc_id      = module.grad_vpc.vpc_id
}

#creat nat

module "nat" {
  source                      = "./nat"
  nat_name                    = "cluatr-nat"
  region                      = module.public_subnets.region[0]
  router_id                   = module.nat_router.router_name
  ip_allocate                 = "AUTO_ONLY"
  source_subnetwork_ip_ranges = "LIST_OF_SUBNETWORKS"
  subnets_name                = module.public_subnets.subnet_name[0]
  ip_range                    = ["ALL_IP_RANGES"]
}

# create firewall
module "iap" {
  source        = "./firewall"
  vpc_name      = module.grad_vpc.vpc_name
  firewall_name = "allow-iap-ssh"
  priority      = 1000
  direction     = "INGRESS"
  protocol      = "tcp"
  ports         = ["80", "22", "8080", "50000"]
  source_ranges = ["0.0.0.0/0"]
}

module "allow-http" {
  source        = "./firewall"
  vpc_name      = module.grad_vpc.vpc_name
  firewall_name = "allow-http"
  priority      = 1000
  direction     = "INGRESS"
  protocol      = "tcp"
  ports         = ["80", "8080", "433", "50000"]
  source_ranges = ["10.0.1.0/24"]
}

# creat sa
module "vm_sa" {
  source     = "./service_acounte"
  account_id = "vm-service"
  roles_list = ["roles/admin"]
  project    = "som3a-iti"
  sa_members = ["serviceAccount:${module.vm_sa.sa_email}"]
}
module "cluster_sa" {
  source     = "./service_acounte"
  account_id = "cluster-service"
  roles_list = ["roles/container.admin", "roles/container.clusterAdmin", "roles/container.clusterViewer", "roles/container.developer", "roles/container.hostServiceAgentUser", "roles/container.viewer", "roles/storage.admin"]
  project    = "som3a-iti"
  sa_members = ["serviceAccount:${module.cluster_sa.sa_email}"]
}
# creat vm
module "Bastion_vm" {
  source      = "./vm"
  vm_name     = "bastion"
  vm_type     = "e2-micro"
  vm_zone     = "europe-north1-a"
  vm_image    = "debian-cloud/debian-10"
  subnet_name = module.public_subnets.subnet_name[0]
  sa_email    = module.vm_sa.sa_email
  sa_scopes   = ["cloud-platform"]
}


#creat cluster 
module "grad_cluster" {
  source                       = "./gka"
  cluster_name                 = "cluster"
  cluste_location              = "europe-north1"
  vpc_id                       = module.grad_vpc.vpc_id
  subnet_id                    = module.private_subnets.subnet_id[0]
  initial_node_count           = 1
  master_ipv4_cidr_block       = ""
  cluster_ipv4_cidr_block      = "10.3.0.0/16"
  services_ipv4_cidr_block     = "10.2.0.0/16"
  master_authorized_cidr_block = "10.0.1.0/24"
  node_pool_name               = "cluster-pool"
  cluster_id                   = module.grad_cluster.cluster_id
  node_count                   = 1
  node_type                    = "e2-medium"
  node_sa_email                = module.cluster_sa.sa_email
  node_oauth_scopes            = ["https://www.googleapis.com/auth/cloud-platform"]
}

resource "local_file" "private_ip" {
  content  = module.Bastion_vm.vm_ip
  filename = "./../../ansible/Inventory"
}