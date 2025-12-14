variable "project-name" {
  default     = "terraform-chander-demo"
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

variable "storage-account-name" {
  description = "Name of the storage account"
  default     = "chanderdemostorage"
}

variable "datafactory-name" {
  description = "Name of the data factory"
  default     = "chanderdemodatafactory"
}
