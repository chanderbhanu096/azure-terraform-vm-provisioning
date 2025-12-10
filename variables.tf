variable "project-name" {
  default     = "terraform_demo"
  description = "Resource group name for all resources"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  default     = "westeurope"
  type        = string
}
variable "admin-username" {
  description = "Admin username for the Linux VM"
  default     = "chander"
  type        = string
}

variable "vm-size" {
  description = "Size of the Linux VM"
  default     = "Standard_F2as_v6"
  type        = string
}

variable "vm-name" {
  description = "Name of the Linux VM"
  default     = "chandervm"
  type        = string
}
