output "route53_publiczone_name" {
   value = "${aws_route53_zone.publiczone.name}"
}

output "route53_publiczone_id" {
  value = "${aws_route53_zone.publiczone.id}"
}

output "route53_r53_delegation_set" {
  value = "${aws_route53_r53_delegation_set.route53_r53_delegation_set_id}"
}
