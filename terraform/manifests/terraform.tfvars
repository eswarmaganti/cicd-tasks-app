aws_region = "us-east-1"
common_tags = {
  environment = "DEV"
  app         = "Tasks App"
}
instance_name    = "dev ec2 instance"
instance_type    = "t3.micro"
public_key_name  = "ec2_dev"
public_key_value = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3r8P24P1NbUT2xvfadUijdpCPpDAPKUZvwVXLPLnQt eswarmaganti@Eswars-MacBook-Air.local"

jenkins_instance_type = "t2.medium"

# vpc input variables
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
