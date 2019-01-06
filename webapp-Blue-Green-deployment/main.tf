

resource "aws_route53_record" "webapp_live_cname_record" {
         provider = "aws.dev.account"
         zone_id = "Z10TFNYAKKKBN"
         name    = "www.${lookup(local.webapp_stacklabels, "appname")}${lookup(local.webapp_stacklabels,"stack_version")}-${lookup(local.webapp_stacklabels,"region")}.bmonoue.net"
         type = "${var.type}"
         ttl = "${var.ttl}"
         records =  ["${var.live_alb_cname}"]
 }
