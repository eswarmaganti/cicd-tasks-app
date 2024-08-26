
output "jenkins_ec2_eip" {
  value = module.ec2_instance.jenkins_ec2_eip
}
output "jenkins_ec2_public_dns" {
  value = module.ec2_instance.jenkins_ec2_public_dns
}
output "dev_app_lb_dns" {
  value = module.alb.dev_app_lb_dns
}

# output "eks_cluster" {
#   value = module.eks.aws_eks_cluster
# }
