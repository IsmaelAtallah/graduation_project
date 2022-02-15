resource "google_compute_instance" "vm" {
  name         = "${var.vm_name}"
  machine_type = "${var.vm_type}"
  zone         = "${var.vm_zone}"
  
  boot_disk{
    initialize_params {
      image = "${var.vm_image}"
    }
  }

  network_interface{
      subnetwork= var.subnet_name
      access_config {
        
      }
  }

  service_account {
    email  = var.sa_email
    scopes = var.sa_scopes
  }
  metadata_startup_script = var.metadata_startup_script
}