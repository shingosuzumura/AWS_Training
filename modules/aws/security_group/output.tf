output "vpc_security_group_ids" {
  value = aws_security_group.public_security_group.id
}