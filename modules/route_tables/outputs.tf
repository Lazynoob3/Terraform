output "public_subnets" {
  description = "The public subnets IDs"
  value       = aws_subnet.public.*.id
}

output "private_subnets" {
  description = "The private subnets IDs"
  value       = aws_subnet.private.*.id
}
