module "dev_vm" {
  source = "../../modules/vm"

  project_id          = var.project_id
  name                = var.vm_name
  zone                = var.zone
  machine_type        = var.machine_type
  boot_image          = var.boot_image
  boot_disk_size_gb   = var.boot_disk_size_gb
  boot_disk_type      = var.boot_disk_type
  network             = var.network
  network_tags        = var.network_tags
  assign_external_ip  = var.assign_external_ip
  deletion_protection = var.deletion_protection

  labels = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

output "vm_name" {
  value = module.dev_vm.name
}

output "vm_internal_ip" {
  value = module.dev_vm.internal_ip
}

output "vm_external_ip" {
  value = module.dev_vm.external_ip
}
