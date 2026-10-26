variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "name" {
  description = "Compute Engine VM name."
  type        = string
}

variable "zone" {
  description = "VM zone."
  type        = string
}

variable "machine_type" {
  description = "Compute Engine machine type."
  type        = string
  default     = "e2-medium"
}

variable "boot_image" {
  description = "Boot image family or image self-link."
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
  description = "VPC network name or self-link."
  type        = string
  default     = "default"
}

variable "network_tags" {
  description = "Network tags."
  type        = list(string)
  default     = []
}

variable "assign_external_ip" {
  description = "Whether to assign an external IPv4 address."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Prevent accidental deletion of the VM."
  type        = bool
  default     = true
}

variable "metadata" {
  description = "VM metadata."
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Resource labels."
  type        = map(string)
  default     = {}
}
