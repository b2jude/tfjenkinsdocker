

output "canarywebapp_dev_record" {
   value = "${aws_route53_record.canary_webapp_dev_cname_record.name}"
}

output "canarywebapp_live_record" {
   value = "${aws_route53_record.canary_webapp_live_cname_record.name}"
}
