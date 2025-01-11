variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  type        = bool
  default     = true
}

variable "name_prefix" {
  description = "Name Prefix added to tag"
  type        = string
}

variable "environment" {
  description = "Define resource environment stage"
  type = string
}
