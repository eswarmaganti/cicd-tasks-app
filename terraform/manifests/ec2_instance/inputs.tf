
variable "dev_instance_type" {
  type = string
}


variable "public_key_name" {
  type = string
}

variable "public_key_value" {
  type = string
}

variable "dev_server_sg_id" {
  type = string
}

variable "jenkins_instance_type" {
  type = string
}

variable "jenkins_sg_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}

variable "ubuntu_ami" {
  type = string
}