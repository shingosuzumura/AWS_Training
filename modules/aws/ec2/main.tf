resource "aws_instance" "this" {
  count                       = 2
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.auth.key_name
  subnet_id                   = element(var.subnet_id, count.index)
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  associate_public_ip_address = true
  user_data                   = var.user_data

  tags = {
    "Name" = "${var.name}_ec2"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = var.public_key_path
}
