variable "stack_labels" {
  type = "map"
}


variable "ami_id" {

}

variable "instancetype" {
  default = "t2.micro"
}

variable "instanceprofile" {

}

variable "userdata" {

}
variable "instance_securitygroup" {
  type = "list"
}
variable "asg_subnets" {
type = "list"
}
/*
variable "instanceport" {

}
variable "instanceprotocol" {}

variable "lbport" {
  default = "80"
}
variable "lbprotocol" {
  default = "HTTP"
}
variable "healthythreshold" {
   default = "3"
}
variable "unhealthythreshold" {
   default = "3"
}

variable "timeout" {
  default = "20"
}
variable "interval" {
  default = "30"
}
*/
data "aws_vpc" "default" {
  default = true
}

variable "maxsize" {
    default = "1"
 }
variable "minsize" {
   default = "1"
}
variable "desirecapacity" {
  default = "1"
}
