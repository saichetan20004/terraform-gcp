variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where the registry will be created"
  type        = string
  default     = "asia-south1"
}

variable "repository_id" {
  description = "The name of the container registry repository"
  type        = string
  default     = "demo"
}