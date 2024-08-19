output "dev_ec2_private_ip" {
  value = module.ec2_instance.dev_ec2_private_ip
}
output "dev_ec2_private_dns" {
  value = module.ec2_instance.dev_ec2_private_dns
}
output "jenkins_ec2_eip" {
  value = module.ec2_instance.jenkins_ec2_eip
}
output "jenkins_ec2_public_dns" {
  value = module.ec2_instance.jenkins_ec2_public_dns
}
# output "eks_cluster" {
#   value = module.eks.aws_eks_cluster
# }