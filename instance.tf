
# Below resource is to create public key
resource "null_resource" "openssl_execution" {
  provisioner "local-exec" {
    command = "ssh-keygen -t rsa -b 4096 -f ${var.aws_public_key_name} -P ''"
  }
}

# Below are the aws key pair
resource "aws_key_pair" "promethus_key_pair" {
  depends_on = ["null_resource.openssl_execution"]
  key_name   = "${var.aws_public_key_name}"
  public_key = "${var.aws_public_key_path}"
}


# promethus instance
resource "aws_instance" "promethus_instance" {
  ami               = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type     = "${var.aws_instance_type}"
  availability_zone = "${var.aws_availability_zone}"
  count             = "1"

  key_name               = "${aws_key_pair.promethus_key_pair.id}"
  vpc_security_group_ids = ["${aws_security_group.promethus_security_group.id}"]
  subnet_id              = "${aws_subnet.promethus_subnet.id}"

  connection {
    user        = "ubuntu"
    host = self.public_ip
    private_key = "${var.aws_private_key_path}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p promethustesting"
    ]
  }

  tags = {
    Name = "${var.name}_instance"
    Environment = "${var.env}"
  }
}

