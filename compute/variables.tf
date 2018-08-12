# -----------compute/variables.tf-----------

variable "private_key_name" {
  default = "tfkey"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "subnet_ips" {
  type = "list"
}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group" {}

variable "subnets" {}
