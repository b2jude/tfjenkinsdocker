locals {
  webapp_stacklabels = {
     appname = "${var.webapp_appname}"
      stack_version = "${var.stack_version}"
      region =  "${var.region}"
  }
}

variable "r53r53_vpc_id" {

}
