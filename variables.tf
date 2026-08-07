variable "aws_region" {
    description = "Region for where project lives"
    type = string
    default = "us-east-1"
}

variable "project_name" {
    description = "Default name of our project"
    type = string
    default = "Three-Tier-App"
}

variable "environment" {
    description = "defines what environment I am deploying resources to"
    type = string
}

variable "vpc_cidr" {
    description = "CIDR defined for VPC"
    type = string
}

variable "public_subnet_cidr_a"{
    description = "CIDR defined for Public Subnet a"
    type = string
}

variable "public_subnet_cidr_b" {
description = "CIDR defined for public subnet b"
type = string
}

variable "private_subnet_cidr_a"{
    description = "CIDR defined for private subnet a"
    type = string
}

variable "private_subnet_cidr_b" {
    description = "CIDR defined for private subnet b"
    type = string
}

variable "instance_type" { 
    description = "instance type defined for instances"
    type = string
}

variable "ami_id" {
    description = "default ami-id defined for instance"
    type = string
}

variable "min_size" {
    description = " Minimum size defined for load balancer"
    type = number
}

variable "max_size" {
    description = "Maximum size defined for load balancer"
    type = number
}

variable "desired_capacity" {
    description = "Ideal size defined for load balancer"
    type = number
}

variable "db_name" {
    description = "default name defined for database"
    type  = string
    default = "Three_tier_app_db"
}

variable "db_username" {
    description = " default username for access to db"
    type = string
    default = "Redni123"
}

variable "db_password" {
    description = "master password for access"
    type = string
    sensitive = true
}

variable "db_instance_class" {
    description = "instance type defined for RDS db"
    type = string
}