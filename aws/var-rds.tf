variable "rds-identifier" {
    description = "Identifier for RDS"
    default = "mage-mysql"
}

variable "rds-instance-class" {
    description = "Instance class for RDS"
    default = "db.t2.micro" # Free tier limitation
}

variable "rds-allocated-storage" {
    description = "Storage size for RDS"
    default = 10 # Maximum of 20GB on free tier
}

variable "rds-storage-type" {
    description = "Storage backend for RDS"
    default = "gp2" # Code for 'SSD' based storage
}

variable "rds-multi-az" {
    description = "Multi-AZ designator for RDS"
    default = false
}

variable "rds-port" {
    description = "Connection port for RDS"
    default = 3306
}

variable "rds-db-name" {
    description = "RDS database name"
    default = "magedb"
}

variable "rds-db-user" {
    description = "RDS database user"
    default = "dbuser"
}

variable "rds-db-password" {
    description = "RDS database password"
    default = "dbpassword"
}
