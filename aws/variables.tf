variable "region" {
    description = "AWS region"
    default = "us-west-2"
}

variable "vpc_cidr" {
    description = "Main CIDR block"
    default = "10.10.0.0/16"
}

variable "public_cidr" {
    description = "CIDR blocks for public subnets"
    default = [
        "10.10.1.0/24",
        "10.10.2.0/24",
        "10.10.3.0/24"
    ]
}

variable "private_cidr" {
    description = "CIDR blocks for private subnets"
    default = [
        "10.10.101.0/24",
        "10.10.102.0/24",
        "10.10.103.0/24"
    ]
}

# AMI

variable "nat-ami" {
    description = "Amazon Linux AMI VPC NAT x86_64 HVM GP2"
    default = "ami-69ae8259"
}
