variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "asia-south1-a"
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "devops-vpc"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "iaas-subnet"
}

# variable "subnet_cidr" {
#   description = "CIDR range for the subnet"
#   type        = string
#   default     = "10.160.0.0/29"
# }

variable "vm_name" {
  description = "The name of the Compute Engine VM"
  type        = string
  default     = "gcp-vm"
}

variable "machine_type" {
  description = "The machine type for the VM"
  type        = string
  default     = "e2-micro"
}

variable "os_image_family" {
  description = "The image family to use for the boot disk"
  type        = string
  default     = "ubuntu-minimal-2504-amd64"
}

variable "os_image_project" {
  description = "The GCP project for the image family"
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}

variable "boot_disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "pd-ssd"
}

variable "data_disk_64_size_gb" {
  description = "First data disk size in GB"
  type        = number
  default     = 64
}

variable "data_disk_type" {
  description = "Data disk type"
  type        = string
  default     = "pd-ssd"
}

variable "ssh_user" {
  description = "The username for SSH login"
  type        = string
}

variable "ssh_public_key" {
  description = "The SSH public key for the VM"
  type        = string
}