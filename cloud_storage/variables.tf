variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region (bucket location)"
  type        = string
  default     = "asia-south1"
}

variable "bucket_name" {
  description = "Name prefix for the GCS bucket"
  type        = string
}