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

variable "aws_key" {
  description = "The local shared aws credentials file"
  type        = string
  default     = "xxxx"
}

variable "aws_profile" {
  description = "The profile used from the local shared aws credentials file"
  type        = string
  default     = "xxxx"
}
