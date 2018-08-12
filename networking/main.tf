# -----------networking/main.tf-----------

# Gather AZ status from AWS
data "aws_availability_zones" "available" {}

# Create VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags {
    Name = "tf_vpc"
  }
}

# Create IGW
resource "aws_internet_gateway" "tf_igw" {
    vpc_id = "${aws_vpc.tf_vpc.id}"

    tags {
      Name = "tf_igw"
    }
}

# Create Public Routing Table
resource "aws_route_table" "tf_public_rt" {
    vpc_id = "${aws_vpc.tf_vpc.id}"

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.tf_igw.id}"
    }

    tags {
      Name = "tf_public_rt"
    }
}

# Create Private Routing Table using Default Routing Table
resource "aws_default_route_table" "tf_private_rt" {
  default_route_table_id = "${aws_vpc.tf_vpc.default_route_table_id}"

  tags {
    Name = "tf_private_rt"
  }
}
