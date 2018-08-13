# -----------./variables.tf-----------

variable "aws_region" {}

#------------Storage Variables

variable "project_name" {}

#------------Networking Variables

variable "vpc_cidr" {}

variable "public_cidrs" {
  type = "list"
}

variable "accessip" {}

#------------Compute Variables

variable "private_key_name" {}
variable "public_key_path" {}

variable "instance_count" {
  default = 1
}

variable "server_instance_type" {}
