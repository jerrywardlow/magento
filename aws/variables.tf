variable "region" {
    description = "AWS region"
    default = "us-west-2"
}

variable "vpc_cidr" {
    description = "Main CIDR block"
    default = "10.10.0.0/16"
}
