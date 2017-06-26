# SSH access list
variable "ssh-access-list" {
    description = "SSH access control list"
    default = [
        "192.0.2.0/24",
        "198.51.100.0/24",
        "203.0.113.0/24"
    ]
}
