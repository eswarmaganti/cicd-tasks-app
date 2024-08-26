variable "dev_app_lb_sg_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}

variable "ssl_certificate_arn" {
  type = string
}
