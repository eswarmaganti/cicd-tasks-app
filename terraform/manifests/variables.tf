variable "aws_region" {
  type        = string
  description = "the region of aws provider"
}
variable "common_tags" {
  type        = map(string)
  description = "common tags for configuration"
}

variable "instance_name" {
  type        = string
  description = "the name of dev ec2 instance"
}
variable "instance_type" {
  type        = string
  description = "dev ec2 instance type"
}
variable "public_key_name" {
  type        = string
  description = "the public key name to access the dev ec2 instance"
}
variable "public_key_value" {
  type        = string
  description = "the value of public key to access the dev ec2 instance"
}
variable "jenkins_instance_type" {
  type        = string
  description = "the ec2 instance type for jenkins server"
}


# VPC variables
variable "vpc_cidr" {
  type        = string
  description = "the cidr block for vpc"
}
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "the cidr blocks for public subnets"
}
variable "availability_zones" {
  type        = list(string)
  description = "the availability zones in which the subnets are going to create"
}
variable "private_subnet_cidrs" {
  type = list(string)
  description = "the cidr blocks for private subnets"
}

variable "domain_name" {
  type = string
  description = "domain name of entire project"
}

variable "app_domain_name" {
  type = string
  description = "subdomain of applicaion"
}