variable "security_group_names" {
  description = "List of security group names"
  type        = list(string)
}

variable "to_port" {
  description = "The TO port used"
  type        = string
}

variable "from_port" {
  description = "The FROM port used"
  type        = string
}

variable "vpc_id" {
  description = "VPC for security groups"
  type = string
}