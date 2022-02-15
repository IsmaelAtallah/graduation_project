variable "vm_name" {}

variable "vm_type" {}

variable "vm_zone"{}

variable "vm_image"{}

variable "subnet_name"{}

variable "sa_email"{}

variable "sa_scopes" {
  type =list(string)
}

variable "metadata_startup_script"{
    type = string
    default = "echo Welcome"
}