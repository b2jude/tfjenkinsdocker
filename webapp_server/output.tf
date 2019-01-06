output "albdns_name"  {
  value = "${module.webappasg.alb_dnsname}"
}

output "albname" {
 value = "${module.webappasg.alb_name}"
}

output "asgname" {
 value = "${module.webappasg.asg_name}"
}


output "alblaunch_config_name" {
    value = "${module.webappasg.alb_launch_config_name}"
}

output "albtargetgroup_arn" {
    value = "${module.webappasg.alb_targetgroup_arn}"
}

output "albtargetgroup_name" {
    value = "${module.webappasg.alb_targetgroup_name}"
}

output "webapp_cname_record" {
   value = "${aws_route53_record.webapp_simple_cname_record.name}"
}
