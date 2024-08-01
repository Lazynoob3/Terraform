variable "vpc_id" {
  description = "The VPC ID where the Internet Gateway will be created"
  type        = string
}

variable "name" {
  description = "The name tag to apply to the Internet Gateway"
  type        = string
  default     = "my-internet-gateway"
}
