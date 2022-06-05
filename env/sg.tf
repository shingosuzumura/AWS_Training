module "security_group" {
  source = "../modules/aws/security_group"

  vpc_id = module.network_main.vpc_id
}