variable "region" {
    description = "AWS region"
    default = "us-west-2"
}

variable "vpc_cidr" {
    description = "Main CIDR block"
    default = "10.10.0.0/16"
}

variable "pub_cidr1" {
    description = "CIDR block for public subnet 1"
    default = "10.10.1.0/24"
}

variable "pub_cidr2" {
    description = "CIDR block for public subnet 2"
    default = "10.10.2.0/24"
}

variable "pub_cidr3" {
    description = "CIDR block for public subnet 3"
    default = "10.10.3.0/24"
}

variable "priv_cidr1" {
    description = "CIDR block for private subnet 1"
    default = "10.10.101.0/24"
}

variable "priv_cidr2" {
    description = "CIDR block for private subnet 2"
    default = "10.10.102.0/24"
}

variable "priv_cidr3" {
    description = "CIDR block for private subnet 3"
    default = "10.10.103.0/24"
}
