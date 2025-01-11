variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the instances"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in Auto Scaling group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in Auto Scaling group"
  type        = number
}

variable "private_subnet_ids" {
  description = "Private subnet ID"
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
