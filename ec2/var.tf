
variable "ami" {
    type = string
    description = "ami value"
    default = "ami-05c13eab67c5d8861"
}

variable "instance_type" {
    type = string
    description = "instance type"
    default = "t2.micro"
}

variable "subnet_id" {
    type = string
    description = "subnet ID to launch ec2 in"   #Note SubnetID is known after VPC is created, so we cnnot pass default subnet id value so we can pass it in main.t

}

variable "tags" {
    type = map(string)
    description = "tags"
}


variable "vpc_id" {
    type = string
    description = "vpc id" 
}