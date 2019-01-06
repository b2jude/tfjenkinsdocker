
resource "aws_route53_record" "webapp_simple_cname_record" {
         provider = "aws.dev.account"
         zone_id = "Z10TFNYAKKKBN"
         name    = "www.${lookup(local.webapp_stacklabels, "appname")}${lookup(local.webapp_stacklabels,"stack_version")}-${lookup(local.webapp_stacklabels,"region")}.bmonoue.net"
         type = "${var.type}"
         ttl = "${var.ttl}"
         records =  ["${module.webappasg.alb_dnsname}"]
 }
