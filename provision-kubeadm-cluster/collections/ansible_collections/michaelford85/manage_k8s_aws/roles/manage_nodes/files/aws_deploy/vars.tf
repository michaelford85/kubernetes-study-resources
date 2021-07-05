variable "num_instances" {
  description = "The number of instances to deploy in the public cloud"
  type        = number
  default     = 1
}

variable "ec2_image_id" {
  description = "The image ID to use for the cloud instance"
  type        = string
  default     = "xxxx"
}

variable "machine_type" {
  description = "The instance type to use for the cloud instance"
  type        = string
  default     = "xxxx"
}

variable "access_key" {
  description = "The access key associates with the AWS account"
  type        = string
  default     = "xxxx"
}

variable "secret_key" {
  description = "The secret key associated with the AWS account"
  type        = string
  default     = "xxxx"
}

variable "ec2_region" {
  description = "The GCP region to operate in"
  type        = string
  default     = "xxxx"
}

variable "ec2_prefix" {
  description = "The prefix to place in front of all ec2 resources"
  type        = string
  default     = "xxxx"
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

/*
variable "application" {
  description = "The application being installed on the linux instances"
  type        = string
  default     = "xxxx"
}
*/
