# Public Subnets
resource "google_compute_subnetwork" "public" {
  for_each                 = toset(local.zones)
  name                     = "public-${each.key}"
  ip_cidr_range            = "10.10.${index(local.zones, each.key)}.0/24"
  region                   = var.gcp_region
  network                  = google_compute_network.vpc.name
  private_ip_google_access = false
}

resource "google_compute_route" "public_internet" {
  name             = "public-subnet-internet-route"
  network          = google_compute_network.vpc.name
  dest_range       = "0.0.0.0/0"
  priority         = 1000
  next_hop_gateway = "default-internet-gateway"
  tags             = ["public"]
}

