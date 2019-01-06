
module "internal_r53_zone" {
  source = "./modules/route53-private-zone"
  stack_labels = "${local.webapp_stacklabels}"
   r53_vpc_id = "${var.r53.r53_vpc_id}"
  providers = {
    aws.the_provider_alias = "aws.developer"
  }
}
