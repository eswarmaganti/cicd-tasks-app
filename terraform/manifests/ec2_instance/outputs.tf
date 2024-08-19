
output "dev_ec2_private_dns" {
  value = aws_instance.dev_ec2.private_dns
}

output "dev_ec2_private_ip" {
  value = aws_instance.dev_ec2.private_ip
}

output "jenkins_ec2_eip" {
  value = aws_eip.jenkins_eip.public_ip
}


output "jenkins_ec2_public_dns" {
  value = aws_eip.jenkins_eip.public_dns
}

