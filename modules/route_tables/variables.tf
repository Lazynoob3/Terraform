variable "vpc_id" {
  description = "The VPC ID where the route tables will be created"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs that will be associated with the public route table"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs that will be associated with the private route table"
  type        = list(string)
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway to associate with the public route table"
  type        = string
}
