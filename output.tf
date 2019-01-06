output "live_url" {
  value = "${aws_route53_record.cname.name}"
}

output "elb_dns" {
 value = "${aws_elb.asg-elb.dns_name}"
}
