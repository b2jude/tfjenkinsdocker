provider "aws" {

  alias = "dns"

}



data "aws_caller_identity" "current" {

  provider = "aws.dns"

}



resource "aws_route53_record" "dev_cname_record" {

  zone_id = "${var.zone_id}"

  name    = "${var.function}.${var.zone_name}"

  type    = "${var.type}"

  ttl     = "${var.ttl}"

  records =  ["${var.dev_alb_dns_cname}"]



  set_identifier = "dev"



   weighted_routing_policy {

     weight = "${var.dev_alb_weight}"

   }

  provider = "aws.dns"

}



resource "aws_route53_record" "live_cname_record" {

  zone_id = "${var.zone_id}"

  name    = "${var.function}.${var.zone_name}"

  type    = "${var.type}"

  ttl     = "${var.ttl}"

  records =  ["${var.live_alb_dns_cname}"]



  set_identifier = "live"



   weighted_routing_policy {

     weight = "${var.live_alb_weight}"

   }

  provider = "aws.dns"

}
