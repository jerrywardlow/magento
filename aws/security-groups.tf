# Load balancer security group
resource "aws_security_group" "elb" {
    name = "magento-elb"
    description = "All app server traffic on port 80"
    vpc_id = "${aws_vpc.default.id}"

    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "magento-elb"
        group = "mage-sg"
    }
}

# NAT
resource "aws_security_group" "nat" {
    name = "wordpress-nat"
    description = "Security group for NAT instance"
    vpc_id = "${aws_vpc.default.id}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = "${var.private_cidr}"
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = "${var.private_cidr}"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "magento-nat"
        group = "mage-sg"
    }
}
