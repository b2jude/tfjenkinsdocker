



variable "stack_version" {}


variable "webapp_appname" {}
variable "live_alb_cname" {}
variable "region" {}

locals {
  webapp_stacklabels = {
     appname = "${var.webapp_appname}"
      stack_version = "${var.stack_version}"
      region = "${var.region}"
  }
}

variable "type" {
  default = "CNAME"
}

variable "ttl" {
  default = 300
}
