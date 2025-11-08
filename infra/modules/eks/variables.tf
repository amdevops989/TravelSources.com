variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "env" {
  type    = string
  default = "dev"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "node_instance_type" {
  type    = string
  default = "t3.small"
}

variable "node_desired_capacity" {
  type    = number
  default = 1
}

variable "node_min_capacity" {
  type    = number
  default = 1
}

variable "node_max_capacity" {
  type    = number
  default = 2
}

variable "ssh_key_name" {
  type    = string
  default = ""
}

variable "k8s_version" {
  type    = string
  default = "1.28"
}

variable "kms_key_id" {
  type = string
}
