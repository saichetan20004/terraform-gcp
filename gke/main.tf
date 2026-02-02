provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  remove_default_node_pool = true
  deletion_protection = false
  initial_node_count = 1

  networking_mode    = "VPC_NATIVE"
  ip_allocation_policy {}
  release_channel {
    channel = "REGULAR"
  }

  # Regional cluster for HA
  node_locations = var.zones
}

resource "google_container_node_pool" "primary_nodes" {
  name       = var.user_pool_name
  cluster    = google_container_cluster.primary.name
  location   = var.region

  node_count = var.initial_node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    preemptible  = false
    metadata = {
      disable-legacy-endpoints = "true"
    }
    # Optionally, set disk size/type, labels, taints, etc.
    disk_size_gb = 50
    disk_type    = "pd-standard"
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
}