
output "jenkins_ec2_eip" {
  value = aws_eip.jenkins_eip.public_ip
}

output "jenkins_ec2_public_dns" {
  value = aws_eip.jenkins_eip.public_dns
}

