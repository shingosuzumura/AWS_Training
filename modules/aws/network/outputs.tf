output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.*.id
}

output "vpc_security_group_ids" {
  value = aws_security_group.public_security_group.id
}
# output "private_subnet_id" {
#   value = module.public.id
# }