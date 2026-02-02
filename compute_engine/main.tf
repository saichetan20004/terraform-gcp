provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

# Data sources to refer to existing VPC and subnet
data "google_compute_network" "vpc_network" {
  name = var.network_name
}

data "google_compute_subnetwork" "subnet" {
  name   = var.subnet_name
  region = var.region
}

resource "google_compute_disk" "data_disk_64" {
  name  = "${var.vm_name}-data-disk-0"
  type  = var.data_disk_type
  zone  = var.zone
  size  = var.data_disk_64_size_gb
}

data "google_compute_image" "ubuntu" {
  family  = var.os_image_family
  project = var.os_image_project
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = var.boot_disk_size_gb
      type  = var.boot_disk_type
    }
  }

  attached_disk {
    source      = google_compute_disk.data_disk_64.id
    device_name = "${var.vm_name}-data-disk-0"
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.id

    access_config {
    # This block provisions a public IP for the VM. If not needed, remove this block.
    }
  }

  tags = ["http-server", "https-server"]

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }
}

output "private_vm_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
  description = "The private IP address of the VM"
}