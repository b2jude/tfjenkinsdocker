

resource "aws_route53_record" "canary_webapp_dev_cname_record" {
          provider = "aws.dev.account"
         zone_id = "Z10TFNYAKKKBN"
         name    = "www.${lookup(local.webapp_stacklabels, "appname")}${lookup(local.webapp_stacklabels,"stack_version")}-${lookup(local.webapp_stacklabels,"region")}.bmonoue.net"
         type = "${var.type}"
         ttl = "${var.ttl}"
         records =  ["${var.dev_alb_cname}"]

         set_identifier = "dev"

         weighted_routing_policy {
             weight = "${var.dev_alb_weight}"
         }
 }


 resource "aws_route53_record" "canary_webapp_live_cname_record" {
           provider = "aws.dev.account"
          zone_id = "Z10TFNYAKKKBN"
          name    = "www.${lookup(local.webapp_stacklabels, "appname")}${lookup(local.webapp_stacklabels,"stack_version")}-${lookup(local.webapp_stacklabels,"region")}.bmonoue.net"
          type = "${var.type}"
          ttl = "${var.ttl}"
          records =  ["${var.live_alb_cname}"]

          set_identifier = "live"

          weighted_routing_policy {
              weight = "${var.live_alb_weight}"
          }
  }
