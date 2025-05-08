variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "ec2_types" {
  type = list(string)
}

variable "workers_desired" {
  type = number
}
variable "workers_max" {
  type = number
}
variable "workers_min" {
  type = number
}

variable "k8s_version" {
  type = string
}