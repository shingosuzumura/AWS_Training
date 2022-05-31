module "network_main" {
  #読み込むmoduleのディレクトリを指定
  source = "../modules/aws/network"
  #以下がmoduleに渡すvariables達
  #左辺がmodulesのvariablesに渡される
  name                   = "test_network"
  vpc_cidr               = var.vpc_cidr[terraform.workspace]
  subnets_public_cidr    = var.vpc_public_subnets[terraform.workspace]
  subnets_private_cidr   = var.vpc_private_subnets[terraform.workspace]
  availability_zone      = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}

module "ec2" {
  source = "../modules/aws/ec2"

  ami                    = "ami-02c3627b04781eada"
  instance_type          = var.instance_type[terraform.workspace]
  vpc_id                 = module.network_main.vpc_id
  subnet_id              = module.network_main.public_subnet_id[0]
  vpc_security_group_ids = module.network_main.vpc_security_group_ids
  key_name               = var.key_name[terraform.workspace]
  public_key_path        = var.public_key_path[terraform.workspace]
}