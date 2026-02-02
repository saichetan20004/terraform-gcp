provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "docker_repo" {
  provider      = google
  location      = var.region
  repository_id = var.repository_id
  description   = "Docker repository with target 5GB storage"
  format        = "DOCKER"
  labels = {
    environment = "dev"
  }
  docker_config {
    immutable_tags = false
  }
}