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

module "ec2_instance" {
  source             = "./ec2_instance"
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  public_key_name  = var.public_key_name
  public_key_value = var.public_key_value

  dev_instance_type = var.instance_type
  dev_server_sg_id  = module.security_groups.dev_server_sg_id

  # jenkins
  jenkins_instance_type = var.jenkins_instance_type
  jenkins_sg_id         = module.security_groups.jenkins_sg_id

  ubuntu_ami = module.ami.ubuntu_ami

  depends_on = [module.vpc]
}



# module "eks" {
#   source = "./eks"
#   master_arn = module.iam.master_arn
#   worker_arn = module.iam.worker_arn
#   public_subnet_ids = module.vpc.public_subnet_ids
#   availability_zones = var.availability_zones
#   instance_type = var.instance_type
#   public_key_name = var.public_key_name
#   eks_sg_id = module.security_groups.eks_sg_id
#   ubuntu_ami = module.ami.ubuntu_ami
# }
