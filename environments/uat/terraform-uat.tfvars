# Replace with the GCP project ID you are authorized to use.
project_id = "dev-proj-512805"

region = "us-central1"
zone   = "us-central1-a"

vm_name             = "uat-reusable-vm"
machine_type        = "e2-medium"
boot_image          = "debian-cloud/debian-12"
boot_disk_size_gb   = 20
boot_disk_type      = "pd-balanced"
network             = "default"
network_tags        = []
assign_external_ip  = false
deletion_protection = true
