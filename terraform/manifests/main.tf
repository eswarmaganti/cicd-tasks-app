module "iam" {
  source = "./iam"

}

module "vpc" {
  source               = "./vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}


module "security_groups" {
  source          = "./security_groups"
  vpc_id          = module.vpc.vpc_id
  dev_sg_name     = "dev server security group"
  jenkins_sg_name = "jenkins server security group"
}

module "ami" {
  source = "./ami"
}



module "auto_scaling_group" {
  source             = "./auto_scaling_group"
  image_id           = module.ami.ubuntu_ami
  instance_type      = var.instance_type
  dev_server_sg_id   = module.security_groups.dev_server_sg_id
  public_key_name    = var.public_key_name
  public_key_value   = var.public_key_value
  dev_app_lb_tg      = module.alb.dev_app_lb_tg
  private_subnet_ids = module.vpc.private_subnet_ids
}


module "ec2_instance" {
  source                   = "./ec2_instance"
  jenkins_ec2_keypair_name = module.auto_scaling_group.dev_ec2_keypair_name
  jenkins_instance_type    = var.jenkins_instance_type
  jenkins_sg_id            = module.security_groups.jenkins_sg_id
  public_subnet_ids        = module.vpc.public_subnet_ids
  private_subnet_ids       = module.vpc.private_subnet_ids
  ubuntu_ami               = module.ami.ubuntu_ami
}


module "certificate_manager" {
  source                = "./certificate_manager"
  domain_hosted_zone_id = module.route53.domain_hosted_zone_id
  domain_name           = var.app_domain_name
}

module "alb" {
  source              = "./alb"
  dev_app_lb_sg_id    = module.security_groups.dev_app_lb_sg_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  vpc_id              = module.vpc.vpc_id
  ssl_certificate_arn = module.certificate_manager.ssl_certificate_arn
}

module "route53" {
  source             = "./route53"
  domain_name        = var.domain_name
  app_domain_name    = var.app_domain_name
  dev_app_lb_dns     = module.alb.dev_app_lb_dns
  dev_app_lb_zone_id = module.alb.dev_app_lb_zone_id
}


module "eks" {
  source             = "./eks"
  master_arn         = module.iam.master_arn
  worker_arn         = module.iam.worker_arn
  private_subnet_ids = module.vpc.private_subnet_ids
  availability_zones = var.availability_zones
  instance_type      = var.instance_type
  public_key_name    = var.public_key_name
  eks_sg_id          = module.security_groups.eks_sg_id
}
