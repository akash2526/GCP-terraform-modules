variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Google Cloud region."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Google Cloud zone."
  type        = string
  default     = "us-central1-a"
}

variable "vm_name" {
  description = "VM name."
  type        = string
  default     = "uat-reusable-vm"
}

variable "machine_type" {
  description = "Machine type."
  type        = string
  default     = "e2-medium"
}

variable "boot_image" {
  description = "Boot image."
  type        = string
  default     = "debian-cloud/debian-12"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB."
  type        = number
  default     = 20
}

variable "boot_disk_type" {
  description = "Boot disk type."
  type        = string
  default     = "pd-balanced"
}

variable "network" {
  description = "Existing VPC network."
  type        = string
  default     = "default"
}

variable "network_tags" {
  description = "Network tags."
  type        = list(string)
  default     = []
}

variable "assign_external_ip" {
  description = "Assign external IP."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection."
  type        = bool
  default     = true
}
