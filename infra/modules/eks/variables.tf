variable "cluster_name" {}
variable "region" {}
variable "profile" {}
variable "env" {}
variable "vpc_id" {}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
  default = []
}

variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
}
variable "node_instance_type" {
  default = "t3.small"
}
variable "node_desired_capacity" {
  default = 1
}
variable "node_min_capacity" {
  default = 1
}
variable "node_max_capacity" {
  default = 2
}
variable "ssh_key_name" {
  default = ""
}
variable "kms_key_id" {}
variable "tags" {
  type    = map(string)
  default = {}
}
