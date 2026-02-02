variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "asia-south1"
}

variable "zones" {
  type        = list(string)
  description = "GCP zones for the regional cluster"
  default     = ["asia-south1-a", "asia-south1-b", "asia-south1-c"]
}

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
  default     = "my-gke-cluster"
}

variable "user_pool_name" {
  type        = string
  description = "Name of the GKE node pool"
  default     = "user-pool"
}

variable "machine_type" {
  type        = string
  description = "Machine type for worker nodes"
  default     = "e2-small" # 16 vCPU, 64GB RAM
}

variable "initial_node_count" {
  type        = number
  description = "Initial total node count (across all zones)"
  default     = 2
}

variable "min_node_count" {
  type        = number
  default     = 2
}

variable "max_node_count" {
  type        = number
  default     = 3
}