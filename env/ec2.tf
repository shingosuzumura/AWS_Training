module "ec2" {
  source = "../modules/aws/ec2"

  name                   = "test_network"
  ami                    = "ami-02c3627b04781eada"
  instance_type          = var.instance_type[terraform.workspace]
  vpc_id                 = module.network_main.vpc_id
  subnet_id              = module.network_main.public_subnet_id
  vpc_security_group_ids = module.security_group.vpc_security_group_ids
  key_name               = var.key_name[terraform.workspace]
  public_key_path        = var.public_key_path[terraform.workspace]
  user_data              = file("./install_apache.sh")
}