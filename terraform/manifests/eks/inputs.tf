variable "master_arn" {
  type = string
}
variable "worker_arn" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "availability_zones" {
  type = list(string)
}
variable "instance_type" {
  type = string
}
variable "public_key_name" {
  type = string
}
variable "eks_sg_id" {
  type = string
}
