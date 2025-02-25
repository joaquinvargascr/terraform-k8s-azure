variable "location" {
  default = "australiasoutheast"
  type    = string
}

variable "resource_group_name" {
  default = "k8s-rg"
  type    = string
}

variable "aks_name" {
  default = "k8s-aks"
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "ns_name" {
  default = "app-ns"
  type    = string
}
