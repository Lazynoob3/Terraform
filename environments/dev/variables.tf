# environments/dev/variables.tf
variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "ap-south-1"
}
