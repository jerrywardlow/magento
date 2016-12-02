provider "aws" {
    region = "${var.region}"
}

resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "magento"
    }
}

resource "aws_key_pair" "magento" {
    key_name = "magento-key"
    public_key = "${file("ssh/magento-key.pub")}"
}
