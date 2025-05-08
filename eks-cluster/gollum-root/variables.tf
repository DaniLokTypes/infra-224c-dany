variable "root_var_ec2_types" {
  type = list(string)
}

variable "root_var_workers_desired" {
  type = number
}

variable "root_var_workers_max" {
  type = number
}

variable "root_var_workers_min" {
  type = number
}

variable "root_var_k8s_version" {
  type = string
}

variable "root_var_vpc_cidr" {
  type = string
}

variable "root_var_subnet_cidrs" {
  type = list(string)
}

variable "root_var_availability_zones" {
  type = list(string)
}

variable "root_var_project" {
  type = string
}

variable "root_var_environment" {
  type = string
}