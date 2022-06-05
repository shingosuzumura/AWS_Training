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
