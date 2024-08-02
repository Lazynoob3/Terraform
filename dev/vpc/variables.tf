variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "name" {
  description = "The name of the VPC"
  type        = string
  default     = "dev-vpc"
}
