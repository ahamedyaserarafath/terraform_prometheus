
#Create the promethus vpc
resource "aws_vpc" "promethus_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.name}_vpc"
    Environment = "${var.env}"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "promethus_ig" {
  vpc_id = "${aws_vpc.promethus_vpc.id}"

  tags = {
    Name = "${var.name}_ig"
    Environment = "${var.env}"
  }

}

# Grant the VPC internet access on its main route table
resource "aws_route" "promethus_internet_access" {
  route_table_id         = "${aws_vpc.promethus_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.promethus_ig.id}"
}

resource "aws_subnet" "promethus_subnet" {
  vpc_id                  = "${aws_vpc.promethus_vpc.id}"
  cidr_block              = "${var.promethus_server_subnet_cidr1}"
  availability_zone       = "${var.aws_availability_zone}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}_subnet"
    Environment = "${var.env}"
  }

}

resource "aws_route_table" "promethus_route_table" {
    vpc_id = "${aws_vpc.promethus_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.promethus_ig.id}"
    }
  tags = {
    Name = "${var.name}_route_table"
    Environment = "${var.env}"
  }
}

resource "aws_route_table_association" "promethus_route_table_association" {
    subnet_id      = "${aws_subnet.promethus_subnet.id}"
    route_table_id = "${aws_route_table.promethus_route_table.id}"
}


resource "aws_security_group" "promethus_security_group" {
  name   = "promethus_security_group"
  description = "Security group for promethus"

  vpc_id = "${aws_vpc.promethus_vpc.id}"


  # Promethus UI
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # SSH access for 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound to Internet to install Docker Images?
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}_sg"
    Environment = "${var.env}"
  }

}
