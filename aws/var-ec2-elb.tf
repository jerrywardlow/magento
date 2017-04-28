# EC2 ELB
variable "elb-name" {
    description = "Application ELB name"
    default = "magento-app-elb"
}

# Listener
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

# Health check
variable "elb-healthy-threshold" {
    description = "ELB healthy threshold"
    default = 2
}

variable "elb-unhealthy-threshold" {
    description = "ELB unhealthy threshold"
    default = 5
}

variable "elb-timeout" {
    description = "ELB health check timeout"
    default = 5
}

variable "elb-target" {
    description = "ELB health check target"
    default = "HTTP:80/"
}

variable "elb-interval" {
    description = "ELB health check interval"
    default = 10
}
