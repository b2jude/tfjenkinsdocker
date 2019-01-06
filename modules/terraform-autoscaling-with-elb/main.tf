/*
provider "aws" {

  alias = "sharedservice"

}


data "aws_caller_identity" "current" {

  provider = "aws.sharedservice"

}
*/

# The user data is backed inside the blue and green images. No nned to add user data here
resource "aws_launch_configuration" "asg_lc" {

  name = "${lookup(var.stack_labels, "appname")}${lookup(var.stack_labels, "stack_version")}_asg_lc"
  image_id = "${var.ami_id}"
  instance_type = "${var.instancetype}"
  security_groups = ["${var.instance_securitygroup}"]
  iam_instance_profile = "${var.instanceprofile}"
  user_data ="${var.userdata}"
  lifecycle {
     create_before_destroy = true
   }

  }

  resource "aws_alb" "asgalb" {

     name = "${lookup(var.stack_labels, "appname")}${lookup(var.stack_labels, "stack_version")}-alb"
     internal = false
     security_groups = ["${var.instance_securitygroup}"]
     subnets = ["${var.asg_subnets}"]
     enable_deletion_protection = false

     /*
     #subnets = ["${split(",", var.asg_vpc_zone_subnets)}"]
     #vpc_zone_identifier = ["${var.asg_subnets}"]


    listener {
      instance_port = "${var.instanceport}"
      instance_protocol = "${var.instanceprotocol}"
      lb_port = "${var.lbport}"
      lb_protocol = "${var.lbprotocol}"
    }

    health_check {
      healthy_threshold = "${var.healthythreshold}"
      unhealthy_threshold = "${var.unhealthythreshold}"
      timeout = "${var.timeout}"
      target = "HTTP:80/index.html"
      interval = "${var.interval}"
    }

    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400
*/
    tags = [
        {
          key = "Name"
          value = "${lookup(var.stack_labels, "appname")}${lookup(var.stack_labels, "stack_version")}"
          propagate_at_lauch = true
        },
    ]
  }

# Create listener
resource "aws_alb_listener" "alb_listener_webapp" {

 load_balancer_arn = "${aws_alb.asgalb.arn}"
 port = "80"
 protocol = "HTTP"
 default_action {
   target_group_arn = "${aws_alb_target_group.alb_targetgroup_webapp.arn}"
   type = "forward"
 }

}

 #Create a target group for alb
resource "aws_alb_target_group" "alb_targetgroup_webapp" {

  name = "${lookup(var.stack_labels, "appname")}${lookup(var.stack_labels, "stack_version")}-albtargetgroup"
  port = "80"
  protocol = "HTTP"
  vpc_id = "${data.aws_vpc.default.id}"
}


  resource "aws_autoscaling_group" "web_appasg" {

    depends_on = ["aws_launch_configuration.asg_lc"]
    name = "${lookup(var.stack_labels, "appname")}${lookup(var.stack_labels, "stack_version")}_asg"
    launch_configuration = "${aws_launch_configuration.asg_lc.name}"
    #availability_zones = ["${split(",", var.asg_availability_zones)}"]
    vpc_zone_identifier = ["${var.asg_subnets}"]
    max_size = "${var.maxsize}"
    min_size = "${var.minsize}"
    desired_capacity = "${var.desirecapacity}"
    force_delete = true
    health_check_grace_period = 500
    health_check_type = "EC2"
    force_delete = true
    #load_balancers = ["${aws_elb.asgelb.name}"]
    target_group_arns = ["${aws_alb_target_group.alb_targetgroup_webapp.arn}"]

    enabled_metrics = ["GroupMinSize","GroupMaxSize","GroupInServiceInstances","GroupPendingInstances","GroupTerminatingInstances","GroupStandbyInstances","GroupTotalInstances","GroupDesiredCapacity"]
    tags = [
        {
          key = "Name"
          value = "${lookup(var.stack_labels, "appname")}${lookup(var.stack_labels, "stack_version")}"
          propagate_at_launch = true
        }
    ]
}
