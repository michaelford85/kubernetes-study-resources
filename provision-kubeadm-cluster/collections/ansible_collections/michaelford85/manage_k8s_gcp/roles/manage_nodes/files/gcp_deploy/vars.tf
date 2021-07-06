variable "num_instances" {
  description = "The number of instances to deploy in the public cloud"
  type        = number
  default     = 1
}

variable "gcp_disk_image" {
  description = "The image ID to use for the cloud instance"
  type        = string
  default     = "xxxx"
}

variable "gcp_region" {
  description = "The GCP region to operate in"
  type        = string
  default     = "pppp"
}

variable "gcp_zone" {
  description = "The GCP zone to operate in"
  type        = string
  default     = "zzzz"
}

variable "gcp_prefix" {
  description = "The prefix to place in front of all gcp resources"
  type        = string
  default     = "ffff"
}

variable "machine_type" {
  description = "The instance type to use for the cloud instance"
  type        = string
  default     = "xxxx"
}

variable "gcp_key" {
  description = "The path to the service account key that will be used to authenticate with GCP"
  type        = string
  default     = "mmmm"
}

variable "gcp_project" {
  description = "The name of the GCP project that this script will operate on"
  type        = string
  default     = "nnnn"
}

variable "cloud_master_volume_size" {
  description = "The block storage volume size for k8s masters"
  type        = number
  default     = 10
}

variable "cloud_worker_volume_size" {
  description = "The block storage volume size for k8s workers"
  type        = number
  default     = 10
}
