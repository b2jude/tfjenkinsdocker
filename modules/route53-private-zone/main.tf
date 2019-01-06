#This is to deploy the route53 zone in a specified provider
#declare the provider
provider "aws" {
  alias = "the_provider_alias"
}

data "aws_caller_identity" "current" {
  provider = "aws.the_provider_alias"
}


resource "aws_route53_zone" "internalzone" {
    provider = "aws.the_provider_alias"
    name = "${lookup(var.stack_labels, "appname")}${lookup(var.stack_labels, "stack_version")}.bmonoue.net"
    vpc_id = "${var.vpc_id}"
    tags = [
       Name = "${lookup(var.stack_labels, "appname")}${lookup(var.stack_labels, "stack_version")}_r53zone"
    ]
}
