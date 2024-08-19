variable "dev_sg_name" {
  type = string
  description = "the name of the security group"
}
variable "jenkins_sg_name" {
  type = string
  description = "the name for jenkins server security group"
}

variable "vpc_id" {
  type = string
  description = "the vpc id to associate the security group"
}