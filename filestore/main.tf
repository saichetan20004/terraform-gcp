provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_filestore_instance" "filestore" {
  name     = var.filestore_name
  location = var.zone
  tier     = "STANDARD"         # Use "PREMIUM" for higher performance
  networks {
    network = var.network
    modes   = ["MODE_IPV4"]
    reserved_ip_range = var.ip_range
  }
  file_shares {
    name       = var.share_name
    capacity_gb = 1024
  }
}