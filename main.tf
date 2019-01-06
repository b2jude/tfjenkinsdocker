provider "aws" {
  region = "us-east-1"
  profile = "developer"
}

/*
terraform {
  required_version = ">= 0.9.1"
  backend "s3" {
    profile = "developer"
    region = "us-east-1"
    bucket = "tf-developer"
    #key = "stack-state.tfstate"
    key = "development/terraform.tfstate"
  }

}
*/

#command line
#$ terraform init -backend-config="bucket=tfstatesbucket" -backend-config="key=terraform.tfstate" -backend-config="region=us-east-1" -backend-config="encrypt=true"

/*
resource "aws_key_pair" "auth" {
 key_name = "${var.key_name}"
 public_key = "${file(var.public_key_path)}"

}
*/

resource "aws_iam_role" "asg_ec2_role" {
    name = "${var.env_alias}_asg_ec2_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
  },
      "Effect": "Allow",
      "Sid": ""
      }
    ]
}
EOF
}


resource "aws_iam_role_policy" "asg_policy" {
    name = "${var.env_alias}_asg_policy"
    role = "${aws_iam_role.asg_ec2_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "autoscaling:*",
      "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": "cloudwatch:PutMetricAlarm",
        "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_instance_profile" "asg_profile" {
    name = "${var.env_alias}_asg_profile"
    role = "${aws_iam_role.asg_ec2_role.name}"
}


resource "aws_security_group" "as_security_grp" {
  name = "${var.env_alias}_asg_sg"
  vpc_id = "${var.vpcid}"
  ingress {
    from_port 	= 22
    to_port 	= 22
    protocol 	= "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port 	= 80
    to_port 	= 80
    protocol 	= "tcp"
    cidr_blocks	= ["0.0.0.0/0"]
  }

  egress {
    from_port	= 0
    to_port 	= 0
    protocol	= "-1"
    cidr_blocks	= ["0.0.0.0/0"]
  }
}

# The user data is backed inside the blue and green images. No nned to add user data here
resource "aws_launch_configuration" "asg_lc" {
  name = "${var.env_alias}_asg_lc"
  image_id = "${var.myami}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.as_security_grp.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.asg_profile.id}"
#  user_data = "${var.userdata}"
  user_data ="${file("myscript.sh")}"
  #key_name = "${aws_key_pair.auth.id}"
  }

  resource "aws_elb" "asg-elb" {
    name = "${var.env_alias}-elb"
    #subnets = ["${var.asg_vpc_zone_subnets}"]
     subnets = ["${split(",", var.asg_vpc_zone_subnets)}"]
    security_groups = ["${aws_security_group.as_security_grp.id}"]
    internal = false
    listener {
      instance_port = 80
      instance_protocol = "http"
      lb_port = 80
      lb_protocol = "http"
    }

    health_check {
      healthy_threshold = 5
      unhealthy_threshold = 5
      timeout = 20
      target = "HTTP:80/index.html"
      interval = 30
    }

    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400

    tags {
      Name = "${var.env_alias}-elb"
    }
  }


  resource "aws_autoscaling_group" "myasg" {
    depends_on = ["aws_launch_configuration.asg_lc"]
    name = "${var.env_alias}_asg"
    availability_zones = ["${split(",", var.asg_availability_zones)}"]
    vpc_zone_identifier = ["${split(",", var.asg_vpc_zone_subnets)}"]
    max_size = 3
    min_size = 1
    desired_capacity = 3
    health_check_grace_period = 500
    health_check_type = "ELB"
    force_delete = true
    load_balancers = ["${aws_elb.asg-elb.name}"]
    launch_configuration = "${aws_launch_configuration.asg_lc.id}"
    enabled_metrics = ["GroupMinSize","GroupMaxSize","GroupInServiceInstances","GroupPendingInstances","GroupTerminatingInstances","GroupStandbyInstances","GroupTotalInstances","GroupDesiredCapacity"]

}

/*
resource "aws_route53_zone" "revportzone" {

  name = "${var.env_alias}revportzone.local"
  vpc_id = "vpc-cd16c4b7"
  tags {
    Name = "${var.env_alias}_revportzone"
  }
}


resource "aws_route53_record" "cname" {
  zone_id = "${aws_route53_zone.revportzone.zone_id}"
  name    = "web${var.env_alias}.${aws_route53_zone.revportzone.name}"
  type    = "CNAME"
  ttl     = "5"

  records        = ["${aws_elb.asg-elb.dns_name}"]
}
*/

resource "aws_route53_record" "cname" {
  zone_id = "Z10TFNYAKKKBN"
  name    = "webapp.bmonoue.net"
  type    = "CNAME"
  ttl     = "5"

  records        = ["${aws_elb.asg-elb.dns_name}"]
  }
