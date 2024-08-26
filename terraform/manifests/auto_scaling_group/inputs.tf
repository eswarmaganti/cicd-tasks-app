variable "image_id" {
  type = string
}

variable "instance_type" {
  type = string
}
variable "dev_server_sg_id" {
  type = string
}

variable "public_key_name" {
  type = string
}

variable "public_key_value" {
  type = string
}
variable "dev_app_lb_tg" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}
