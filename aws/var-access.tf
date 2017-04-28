# SSH access list
variable "ssh-access-list" {
    description = "SSH access control list"
    default = [
        "8.8.8.8/32",
        "169.254.169.254/32"
    ]
}
