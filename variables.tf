variable "name" {
  description = "A unique id for the deployment"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags that are added to resources"
  type        = map(string)
  default     = {}
}

variable "create" {
  type        = bool
  default     = true
  description = "Boolean to determine if you should create the instance or destroy all associated resources"
}

#####
# ec2
#####
variable "key_name" {
  description = "The key pair to import"
  type        = string
  default     = ""
}

variable "root_volume_size" {
  description = "Root volume size"
  type        = string
  default     = 8
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3a.small"
}

variable "public_key_path" {
  description = "The path to the public ssh key"
  type        = string
}

variable "private_key_path" {
  description = "The path to the private ssh key"
  type        = string
}