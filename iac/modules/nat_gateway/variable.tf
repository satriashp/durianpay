variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of Public subnet ids"
  type        = list(string)
}

variable "name_prefix" {
  description = "Name Prefix added to tag"
  type        = string
}

variable "environment" {
  description = "Define resource environment stage"
  type = string
}
