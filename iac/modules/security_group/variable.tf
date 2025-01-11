variable "vpc_id" {
  description = "VPC ID for the security group"
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
