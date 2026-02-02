provider "google" {
  project = var.project_id
  region  = var.region
}

resource "random_id" "unique" {
  byte_length = 4
}

resource "google_storage_bucket" "bucket" {
  name          = "${var.bucket_name}-${random_id.unique.hex}" # ensure globally unique name
  location      = var.region
  force_destroy = true
  storage_class = "STANDARD"

  lifecycle_rule {
    condition {
      age = 30  # deletes objects older than 30 days
    }
    action {
      type = "Delete"
    }
  }
}

output "bucket_name" {
  value       = google_storage_bucket.bucket.name
  description = "The name of the created GCS bucket"
}