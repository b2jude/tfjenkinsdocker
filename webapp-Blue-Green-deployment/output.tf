

output "webapp_live_record" {
   value = "${aws_route53_record.webapp_live_cname_record.name}"
}
