# -----------compute/main.tf-----------

# Query AWS for list of Amazon AMI images
data "aws_ami" "server_ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name = "name"

    # Amazon
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "tf_auth" {
  key_name   = "${var.private_key_name}"
  public_key = "${file(var.public_key_path)}"
}

data "template_file" "user-init" {
  count    = 2
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    firewall_subnets = "${element(var.subnet_ips, count.index)}"
  }
}

resource "aws_instance" "tf_server" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${data.aws_ami.server_ami.id}"

  tags {
    Name = "tf_server-${count.index + 1}"
  }

  key_name               = "${aws_key_pair.tf_auth.id}"
  vpc_security_group_ids = ["${var.security_group}"]

  # element() is another way of doing ${var.subnets[count.index]}
  subnet_id = "${element(var.subnets, count.index)}"
  user_data = "${data.template_file.user-init.*.rendered[count.index]}"
}
