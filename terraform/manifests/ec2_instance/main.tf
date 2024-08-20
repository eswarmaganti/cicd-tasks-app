
# creating a keypair to access the server
resource "aws_key_pair" "dev_ec2_keypair" {
  public_key = var.public_key_value
  key_name   = var.public_key_name
}

# creating an ec2 instance in private subnet
resource "aws_instance" "dev_ec2" {
  subnet_id              = var.private_subnet_ids[0]
  ami                    = var.ubuntu_ami
  instance_type          = var.dev_instance_type
  key_name               = aws_key_pair.dev_ec2_keypair.key_name
  vpc_security_group_ids = [var.dev_server_sg_id]
  user_data              = templatefile("./scripts/init.sh", {})
  tags = {
    name = "Dev Server"
  }
}


# create a ec2 server for jenkins in public instance
resource "aws_instance" "jenkins_ec2" {
  subnet_id              = var.public_subnet_ids[1]
  instance_type          = var.jenkins_instance_type
  ami                    = var.ubuntu_ami
  key_name               = aws_key_pair.dev_ec2_keypair.key_name
  vpc_security_group_ids = [var.jenkins_sg_id]
  user_data              = templatefile("./scripts/jenkins_init.sh", {})
  root_block_device {
    volume_size           = 40
    volume_type           = "gp2"
    delete_on_termination = true
  }
  tags = {
    Name        = "Jenkins Server"
    description = "A Jenkins server to expose jenkins application to create CICID pipelines"
  }
}

# associate a eip for jenkins server
resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins_ec2.id
  domain   = "vpc"
}

# file provisioner to copy the private key to jenkins ec2 instance

resource "null_resource" "file_provisioner" {
  connection {
    host        = aws_eip.jenkins_eip.public_ip
    user        = "ubuntu"
    type        = "ssh"
    private_key = file("/Users/eswarmaganti/.ssh/dev_ec2")
  }
  provisioner "file" {
    source      = "/Users/eswarmaganti/.ssh/dev_ec2"
    destination = "/home/ubuntu/.ssh/dev_ec2"
    
  }
}
