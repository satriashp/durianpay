variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "name_prefix" {
  description = "Name Prefix added to tag"
  type        = string
}

variable "environment" {
  description = "Define resource environment stage"
  type = string
}
