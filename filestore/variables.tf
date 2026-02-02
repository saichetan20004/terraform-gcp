variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "asia-south1-a"
}

variable "filestore_name" {
  description = "Name for the Filestore instance"
  type        = string
  default     = "demofilestore"
}

variable "share_name" {
  description = "Name of the file share"
  type        = string
  default     = "test"
}

variable "network" {
  description = "Self-link or name of the VPC network"
  type        = string
  default     = "devops-vpc"
}

variable "ip_range" {
  description = "Reserved IP range (CIDR block, must not overlap with existing ranges)"
  type        = string
  default     = "10.198.6.0/29"
}