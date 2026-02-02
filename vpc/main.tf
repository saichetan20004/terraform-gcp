provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = { for subnet in var.subnets : subnet.name => subnet }
  name          = each.value.name
  ip_cidr_range = each.value.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}