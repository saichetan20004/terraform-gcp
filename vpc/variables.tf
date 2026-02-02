variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for subnetworks"
  type        = string
  default     = "asia-south1"
}

variable "vpc_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "devops-vpc"
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name        = string
    ip_cidr_range = string
  }))
  default = [
    {
      name         = "iaas-subnet"
      ip_cidr_range = "10.198.1.0/29"
    },
    {
      name         = "gke-subnet"
      ip_cidr_range = "10.198.2.0/23"
    },
    {
      name         = "paas-subnet"
      ip_cidr_range = "10.198.4.0/29"
    }
  ]
}