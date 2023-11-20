variable "cluster_name" {
  default = "development"
}

variable "kube_version" {
  default = "1.25"
}

variable "disk_size" {
  default = "50"
}

variable "spot_instance" {
#  description = "Set to true to use spot instances, false to use on-demand instances."
#  type        = bool
  default     = true
}

