# Load balancer security group
resource "aws_security_group" "elb" {
    name = "magento-elb"
    description = "ELB secuity group"
    vpc_id = "${aws_vpc.default.id}"

    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
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
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = "${var.ssh-access-list}"
    }

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

# Application security group
resource "aws_security_group" "app_asg" {
    name = "mage-app-asg"
    description = "Security group for application ASG"
    vpc_id = "${aws_vpc.default.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = ["${aws_security_group.nat.id}"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.elb.id}"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = ["${aws_security_group.elb.id}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "magento-app-asg"
        groups = "mage-sg"
    }
}

# ElastiCache security group
resource "aws_security_group" "redis" {
    name = "mage-redis"
    description = "Security group for Redis ElastiCache cluster"
    vpc_id = "${aws_vpc.default.id}"

    ingress {
        from_port = "${var.elasticache-port}"
        to_port = "${var.elasticache-port}"
        protocol = "tcp"
        security_groups = [
            "${aws_security_group.nat.id}",
            "${aws_security_group.app_asg.id}"
        ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "magento-redis"
        group = "mage-sg"
    }
}

# RDS security group
resource "aws_security_group" "mysql" {
    name = "mage-mysql"
    description = "Security group for RDS cluster"
    vpc_id = "${aws_vpc.default.id}"

    ingress {
        from_port = "${var.rds-port}"
        to_port = "${var.rds-port}"
        protocol = "tcp"
        security_groups = [
            "${aws_security_group.nat.id}",
            "${aws_security_group.app_asg.id}"
        ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "magento-mysql"
        group = "mage-sg"
    }
}
