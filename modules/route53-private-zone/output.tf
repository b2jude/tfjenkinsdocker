output "route53_internalzone_name" {
   value = "${aws_route53_zone.internalzone.name}"
}

output "route53_internalzone_id" {
  value = "${aws_route53_zone.internalzone.id}"
}
