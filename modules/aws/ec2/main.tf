resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.auth.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.vpc_security_group_ids]
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = var.public_key_path
}