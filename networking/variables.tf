# -----------networking/variables.tf-----------

variable "vpc_cidr" {
  default = "10.255.0.0/16"
}

variable "public_cidrs" {
  default = [
    "10.255.1.0/24",
    "10.255.2.0/24",
  ]
}

variable "accessip" {
  default = "0.0.0.0/0"
}
