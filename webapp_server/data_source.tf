/*
data "aws_vpc" "currentvpc" {
  tags =  {  Name = "${lookup(local.webapp_stacklabels,"appname" )}_${lookup(local.webapp_stacklabels,"region")}a_vpc" }
}
*/

data "aws_vpc" "default" {
  default = true
 provider = "aws.dev.account"
}

data "aws_security_group" "webapp-sg" {
  name = "webapp_sg"
  vpc_id = "${data.aws_vpc.default.id}"
 provider = "aws.dev.account"
}

data "aws_iam_instance_profile" "ec2_profile" {
  name = "${lookup(local.webapp_stacklabels,"appname" )}_asg_profile"
 provider = "aws.dev.account"
}

data "aws_subnet" "public_subnet_az_a" {
 tags =  {  Name = "${lookup(local.webapp_stacklabels,"appname" )}_${lookup(local.webapp_stacklabels,"region")}a_public_subnet" }
 provider = "aws.dev.account"
      }

data "aws_subnet" "public_subnet_az_b" {
 tags =  {  Name = "${lookup(local.webapp_stacklabels,"appname" )}_${lookup(local.webapp_stacklabels,"region")}b_public_subnet" }
 provider = "aws.dev.account"
}

data "aws_subnet" "public_subnet_az_c" {
   tags =  {  Name = "${lookup(local.webapp_stacklabels,"appname" )}_${lookup(local.webapp_stacklabels,"region")}c_public_subnet" }
 provider = "aws.dev.account"
}

data "aws_ami" "ec2-linux" {
   provider = "aws.dev.account"
  most_recent = true
  filter {
    name = "name"
    values = ["amzn-ami-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "owner-alias"
    values = ["amazon"]
  }
}

/*
data "aws_vpc" "webappvpc" {
  tags = {
    Name = "${lookup(local.webapp_stacklabels, "appname").v.${lookup(local.webapp_stacklabels, "release")}}"

      }
}
*/
