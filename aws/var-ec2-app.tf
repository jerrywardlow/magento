# App instance
#data "aws_ami" "app" {
#    most_recent = true
#    filter {
#        name = "name"
#        values = ["packer-built-ami-name*"]
#    }
#    owners = ["pass"] # Account ID for AMI creator/uploader
#}

# Placeholder for Packer built AMI
variable "app-ami" {
    description = "AMI for application instances"
    default = "ami-b63769a1" # Red Hat Enterprise Linux 7.3 (HVM)
}

variable "app-instance-type" {
    description = "EC2 instance type for application ASG"
    default = "t2.micro"
}

variable "asg-health-check-grace-period" {
    description = "Grace period for health checks on new ASG instance"
    default = 300
}

variable "asg-min-size" {
    description = "Minimum number of instances in app ASG"
    default = 2
}

variable "asg-max-size" {
    description = "Maximum number of instances in app ASG"
    default = 5
}
