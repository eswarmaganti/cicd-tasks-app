output "dev_server_sg_id" {
  value = aws_security_group.dev_server_sg.id
}

output "dev-server-sg-arn" {
  value = aws_security_group.dev_server_sg.arn
}

output "jenkins_sg_id" {
  value = aws_security_group.jenkins_server_sg.id
}

output "eks_sg_id" {
  value = aws_security_group.eks_sg.id
}

output "dev_app_lb_sg_id" {
  value = aws_security_group.dev_app_lb_sg.id
}
