variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-1"
}
 
variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "myproject"
}
 
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
 
variable "subnet_cidr" {
  description = "CIDR block for the Subnet"
  type        = string
  default     = "10.0.1.0/24"
}
 
variable "availability_zone" {
  description = "The Availability Zone for the Subnet"
  type        = string
  default     = "us-west-1a"
}
 
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
  default     = "ami-047d7c33f6e7b4bc4" # Update to your desired AMI
}
 
variable "instance_type" {
  description = "The instance type to use for the EC2 instances"
  type        = string
  default     = "t2.micro"
}
 
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 3
}
 
variable "bastion_security_groups" {
  description = "Bastion security group configurations"
  type        = map(object({
    description     = string
    ingress_rules   = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
    egress_rules    = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
  }))
  default = {}
}
 
variable "web_security_groups" {
  description = "Web security group configurations"
  type        = map(object({
    description     = string
    ingress_rules   = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
    egress_rules    = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
  }))
  default = {}
}
 
variable "web_security_groups1" {
  description = "Additional web security group configurations"
  type        = map(object({
    description     = string
    ingress_rules   = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
    egress_rules    = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
  }))
  default = {}
}
 
variable "app_security_groups" {
  description = "App security group configurations"
  type        = map(object({
    description     = string
    ingress_rules   = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
    egress_rules    = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
  }))
  default = {}
}
 
variable "app_security_groups1" {
  description = "Additional app security group configurations"
  type        = map(object({
    description     = string
    ingress_rules   = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
    egress_rules    = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
  }))
  default = {}
}
 
variable "db_security_groups" {
  description = "Database security group configurations"
  type        = map(object({
    description     = string
    ingress_rules   = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
    egress_rules    = optional(list(object({
      description     = optional(string)
      priority        = optional(number)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })))
  }))
  default = {}
}
 
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}