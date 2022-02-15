variable "account_id"{}

variable "roles_list"{
    type = list(string)
}

variable "project" {}


variable "sa_members"{
    type = list(string)
}