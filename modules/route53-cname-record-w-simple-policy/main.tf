provider "aws" {

  alias = "dns"

}



data "aws_caller_identity" "current" {

  provider = "aws.dns"

}



resource "aws_route53_record" "simple_cname_record" {

  zone_id = "${var.zone_id}"

  name    = "${var.function}.${var.zone_name}"

  type    = "${var.type}"

  ttl     = "${var.ttl}"

  records =  ["${var.alb_dns_name}"]

}
