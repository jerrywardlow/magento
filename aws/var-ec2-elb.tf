# EC2 ELB
variable "elb-name" {
    description = "Application ELB name"
    default = "magento-app-elb"
}

variable "elb-instance-port" {
    description = "ELB Listener instance port"
    default = 80
}

variable "elb-lb-port" {
    description = "ELB Listener lb port"
    default = 80
}

variable "elb-instance-protocol" {
    description = "ELB Listener instance protocol"
    default = "http"
}

variable "elb-lb-protocol" {
    description = "ELB Listener lb protocol"
    default = "http"
}
