provider "aws" {
  region = "${var.region}"
  profile = "devaccount"
  alias = "dev.account"
}
