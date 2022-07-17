#************************Google-Networking***********************************************************************

# Module to create Google cloud Global VPC

resource "google_compute_network" "vpc" {
  name = "${var.app_name}-vpc"
  auto_create_subnetworks = "false" 
  routing_mode = "GLOBAL"
}
/*
# Module to create private subnet under Global VPC
resource "google_compute_subnetwork" "private_subnet_1" {
  #provider = google
  purpose = "PRIVATE"
  name = "${var.app_name}-private-subnet-1"
  ip_cidr_range = var.private_subnet_cidr_1
  network = google_compute_network.vpc.name
  region = var.region
}
*/
  
resource "google_compute_subnetwork" "private_subnet" {
  #provider = google
  purpose = "PRIVATE"
  count = length(var.private-subnet)
  name  = var.private-subnet[count.index].name
  ip_cidr_range  = var.private_subnet[count.index].cidr
  network = google_compute_network.vpc.name
  region = var.region
}

# Module to create a public ip for nat service

resource "google_compute_address" "nat-ip" {
  name = "${var.app_name}-nat-ip"
  project = var.project
  region  = var.region
}

# Module to create a nat to allow private instances connect to internet

resource "google_compute_router" "nat-router" {
  name = "${var.app_name}-nat-router"
  network = google_compute_network.vpc.name
}

# Module to create a nat-gatewat to allow private instances connect to internet

resource "google_compute_router_nat" "nat-gateway" {
  name = "${var.app_name}-nat-gateway"
  router = google_compute_router.nat-router.name
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [ google_compute_address.nat-ip.self_link ]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES" 
  depends_on = [ google_compute_address.nat-ip ]
  
  }
output "nat_ip_address" {
  value = google_compute_address.nat-ip.address
 }
