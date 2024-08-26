
# defining the security group for dev server
resource "aws_security_group" "dev_server_sg" {
  vpc_id      = var.vpc_id
  name        = var.dev_sg_name
  description = "the security group for dev server which allows traffic to port 22 for SSH and egress to public internet"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow the dev server to access the public internet"
  }
  ingress {
    description = "Allow port 22 for SSH to the dev server from public internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port 3000 for react frontend application using nginx"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port 5050 to access the node backend"
    from_port   = 5050
    to_port     = 5050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name        = "DEV SERVER SG"
    Environment = "DEV"
  }
}


# Defining the securuty group for jenkins server
resource "aws_security_group" "jenkins_server_sg" {
  vpc_id = var.vpc_id
  name   = var.jenkins_sg_name
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow the dev server to access the public internet"
  }

  ingress {
    description = "Allow port 22 for SSH to the dev server from public internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  description = "The security group to expose the port 8080 for jenkins application"
  ingress {
    description = "Allow port 8080 to access the jenkins server"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow PORT 9000 to expose sonarqube server"
    from_port   = 9000
    to_port     = 9000
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }
  tags = {
    Name        = "Jenkins Server SG"
    Environment = "jenkins"
  }
}


# defining the security group for eks cluster
resource "aws_security_group" "eks_sg" {
  vpc_id      = var.vpc_id
  description = "Security group for EKS cluster"
  ingress {
    description = "Allow port 80 for HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port 443 for HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port 22 for SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow instance to access the public interner"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "EKS SG"
    Environment = "PROD"
  }
}


# defining the security group for application load balencer

resource "aws_security_group" "dev_app_lb_sg" {
  vpc_id      = var.vpc_id
  name        = "dev-app-lb-sg"
  description = "the security group for dev loadbalencer which allows traffic and redirects to dev servers"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow the dev server to access the public internet"
  }
  ingress {
    description = "Allow HTTPS port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP port 80 "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port 3000 for react frontend application using nginx"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port 5050 to access the node backend"
    from_port   = 5050
    to_port     = 5050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name        = "DEV SERVER SG"
    Environment = "DEV"
  }
}