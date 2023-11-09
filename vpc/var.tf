#This is a list of variables var.tf = variables.tf

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet1_cidr_block" {
  description = "CIDR block for public_subnet1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet2_cidr_block" {
  description = "CIDR block for public_subnet2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet1_cidr_block" {
  description = "CIDR block for private_subnet1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet2_cidr_block" {
  description = "CIDR block for private_subnet2"
  type        = string
  default     = "10.0.4.0/24"
}

#VARIABLES FOR AVAILABIBILITY ZONE
variable "availability_zones" {
    description = ""
    type = list(string)
    default = [ "us-east-1a", "us-east-1b" ]    
}

variable "tags" {
    type = map
    description = "tags"
  
}

#VARIABLES FOR TAGS 



#The below is not efficient way to variabilize availability_zone, we can use list or map instead as above "availability_zones"

# variable "public_subnet1_az" {
#   description = "Availability zone for public_subnet1"
#   type        = string
#   default     = "us-east-1a"
# }

# variable "public_subnet2_az" {
#   description = "Availability zone for public_subnet2"
#   type        = string
#   default     = "us-east-1b"
# }

# variable "private_subnet1_az" {
#   description = "Availability zone for private_subnet1"
#   type        = string
#   default     = "us-east-1a"
# }

# variable "private_subnet2_az" {
#   description = "Availability zone for private_subnet2"
#   type        = string
#   default     = "us-east-1b"
# }
