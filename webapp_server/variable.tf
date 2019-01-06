

variable "webapp_appname" {}
variable "webapp_instancetype" {}

variable "webapp_max_size" {}
variable "webapp_min_size" {}
variable "webapp_desirecapacity" {}

variable "stack_version" {}
variable "region" {}

locals {
  webapp_stacklabels = {
     appname = "${var.webapp_appname}"
      stack_version = "${var.stack_version}"
      region =  "${var.region}"
  }
}

variable "type" {
  default = "CNAME"
}

variable "ttl" {
  default = 300
}
