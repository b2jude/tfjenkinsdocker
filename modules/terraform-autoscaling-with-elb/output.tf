output "alb_name" {
  value = ["${aws_alb.asgalb.name}"]
}

output "asg_name" {
    value = "${aws_autoscaling_group.web_appasg.name}"
}

output "alb_dnsname" {
    value = "${aws_alb.asgalb.dns_name}"
}

output "alb_launch_config_name" {
    value = "${aws_launch_configuration.asg_lc.name}"
}

output "alb_targetgroup_arn" {
    value = "${aws_alb_target_group.alb_targetgroup_webapp.arn}"
}

output "alb_targetgroup_name" {
    value = "${aws_alb_target_group.alb_targetgroup_webapp.name}"
}
