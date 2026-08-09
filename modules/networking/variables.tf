variable "vpc_cidr" {
    description = "IP range for VPC"
    type = string
}

variable "public_subnet_cidr_a" {
    description = "IP range for public subnet A"
    type = string
}

variable "public_subnet_cidr_b" {
    description = "IP range for public subnet B"
    type = string
}

variable "private_subnet_cidr_a" {
    description = "IP range for private subnet A"
    type = string
}

variable "private_subnet_cidr_b" {
    description = "IP range for private subnet B"
    type = string
}

variable "name_prefix" {
    description = "Name Prefix for resources"
    type = string
}

variable "common_tags" {
    description = "common tags to be attached to resources"
    type = map(string)
}