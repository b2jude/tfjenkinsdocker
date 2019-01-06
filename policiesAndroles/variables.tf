
variable "appname" {}
variable "stack_version" {}

variable "region" {

  }

locals = {

stack_labels = {
    appname = "${var.appname}"
    stack_version= "${var.stack_version}"
   }
}
